// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/usecase/chat.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/io/repo/extremo/mypage/chat_message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

class ChatMessagePage extends HookConsumerWidget {
  const ChatMessagePage({
    super.key,
    required this.chatFk,
    required this.clientFk,
  });

  final int chatFk;
  final int clientFk;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ------------------
    // 1) 依存リソースの取得
    // ------------------
    final accountNotifier = ref.watch(accountProvider.notifier);
    final account = accountNotifier.account();
    if (account == null) {
      // TODO: エラーハンドリング
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // ChatMessageUseCase を取得
    final useCase = ref.read(chatMessageUseCaseProvider);

    // flutter_chat_ui 用のユーザー
    final user = types.User(
      id: 'user:${account.pk}:${account.dateJoined.seconds}',
      createdAt: account.dateJoined.seconds.toInt(),
    );

    // ------------------
    // 2) ローカルステート管理
    // ------------------
    // メッセージ一覧の管理
    final messagesState = useState<AsyncValue<List<ChatMessageModel>>>(const AsyncValue.loading());

    // ページングが必要ならこちらで用意（例）
    final nextPageState = useState<int>(0);
    final hasMoreState = useState<bool>(true);

    // ------------------
    // 3) メッセージ一覧の初回取得
    // ------------------
    // ※ ページングしたい場合は必要に応じて再呼び出ししてください
    Future<void> fetchMessages() async {
      // hasMore が false の場合は早期returnするなどのロジック
      if (!hasMoreState.value) {
        return;
      }

      messagesState.value = const AsyncValue.loading();
      try {
        final nextModel = await useCase.listChatMessages(
          chatFk: chatFk,
          clientFk: clientFk,
          next: nextPageState.value,
        );
        // 次のページインデックスを更新
        nextPageState.value = nextModel.next;
        if (nextModel.elements.isEmpty) {
          hasMoreState.value = false;
        }

        // 既存データに追加していく
        final current = messagesState.value.asData?.value ?? [];
        final merged = [...current, ...nextModel.elements];
        messagesState.value = AsyncValue.data(merged);
      } on Object catch (e, st) {
        messagesState.value = AsyncValue.error(e, st);
      }
    }

    // 初回マウント時に1回だけ取得
    useEffect(() {
      fetchMessages();
      return null;
    }, []);

    // ------------------
    // 4) メッセージの作成
    // ------------------
    Future<void> addMessage(types.Message message) async {
      final chatMessageModel = ChatMessageModel(
        pk: 0,
        chatFk: chatFk,
        fromFk: account.pk,
        toFk: clientFk,
        message: jsonEncode(message.toJson()),
        isRead: false,
        isDeleted: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final result = await useCase.replyChatMessage(chatMessageModel);
      result.onSuccess((createdModel) {
        // 成功時は既存一覧に追加
        final current = messagesState.value.asData?.value ?? [];
        messagesState.value = AsyncValue.data([...current, createdModel]);
      }).onFailure<Exception>((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message: $error')),
        );
      });
    }

    // ------------------
    // 5) Chat UI まわり
    // ------------------
    // ファイル添付
    void handleAttachmentPressed() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) => SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection(addMessage, user);
                  },
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection(addMessage, user);
                  },
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('File'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // メッセージタップ（ファイルを開く）
    Future<void> handleMessageTap(BuildContext _, types.Message message) async {
      if (message is! types.FileMessage) {
        return;
      }

      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        // ダウンロード開始
        // ダウンロード中の表示を行いたいならここで更新してもいい
        try {
          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          // 最終的に localPath を message の uri にしたい場合は
          // messagesState.value の中の該当メッセージを更新
          final current = messagesState.value.asData?.value ?? [];
          final index = current.indexWhere((m) {
            final decoded = _decodeToTypesMessage(m.message);
            return decoded.id == message.id;
          });
          if (index != -1) {
            final updatedFileMessage = message.copyWith(uri: localPath) as types.FileMessage;
            final updatedJson = jsonEncode(updatedFileMessage.toJson());
            final updatedModel = current[index].copyWith(message: updatedJson);

            final newList = [...current];
            newList[index] = updatedModel;
            messagesState.value = AsyncValue.data(newList);
          }
        }
      }

      // ファイルを開く
      await OpenFilex.open(localPath);
    }

    // リンクプレビュー取得
    void handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
    ) {
      final current = messagesState.value.asData?.value ?? [];
      final index = current.indexWhere((m) {
        final decoded = _decodeToTypesMessage(m.message);
        return decoded.id == message.id;
      });
      if (index == -1) {
        return;
      }

      final updatedMessage = message.copyWith(previewData: previewData);
      final updatedModel = current[index].copyWith(
        message: jsonEncode(updatedMessage.toJson()),
      );

      final newList = [...current];
      newList[index] = updatedModel;
      messagesState.value = AsyncValue.data(newList);
    }

    // 送信（テキスト）
    void handleSendPressed(types.PartialText message) {
      final textMessage = types.TextMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: message.text,
      );
      addMessage(textMessage);
    }

    // ------------------
    // 6) 実際の画面描画
    // ------------------
    return Scaffold(
      body: messagesState.value.when(
        data: (messageModels) {
          final messages = messageModels.map((m) => _decodeToTypesMessage(m.message)).toList();

          return Chat(
            messages: messages,
            onAttachmentPressed: handleAttachmentPressed,
            onMessageTap: handleMessageTap,
            onPreviewDataFetched: handlePreviewDataFetched,
            onSendPressed: handleSendPressed,
            showUserAvatars: true,
            showUserNames: true,
            user: user,
            theme: const DefaultChatTheme(
              seenIcon: Text(
                'read',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  // ------------------
  // 補助関数 (ファイル選択, 画像選択)
  // ------------------
  Future<void> _handleFileSelection(
    void Function(types.Message) addMessage,
    types.User user,
  ) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );
      addMessage(message);
    }
  }

  Future<void> _handleImageSelection(
    void Function(types.Message) addMessage,
    types.User user,
  ) async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );
    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );
      addMessage(message);
    }
  }

  // ------------------
  // JSON -> types.Message 変換用の簡易ヘルパー
  // ------------------
  types.Message _decodeToTypesMessage(String rawMessageJson) {
    final Map<String, dynamic> json = jsonDecode(rawMessageJson) as Map<String, dynamic>;
    return types.Message.fromJson(json);
  }
}

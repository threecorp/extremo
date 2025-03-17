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
    final accountNotifier = ref.watch(accountProvider.notifier);
    final account = accountNotifier.account();
    if (account == null) {
      // TODO(unimpl): error handling
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    final useCase = ref.read(chatMessageUseCaseProvider);

    // for flutter_chat_ui user
    final user = types.User(
      id: 'user:${account.pk}:${account.dateJoined.seconds}',
      createdAt: account.dateJoined.seconds.toInt(),
    );

    // local state
    final messagesState = useState<AsyncValue<List<ChatMessageModel>>>(const AsyncValue.loading());
    final nextPageState = useState<int>(0);
    final hasMoreState = useState<bool>(true);

    // if you want to implement pagination, call this function when needed
    Future<void> fetchMessages() async {
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

        // next index
        nextPageState.value = nextModel.next;
        if (nextModel.elements.isEmpty) {
          hasMoreState.value = false;
        }

        // append to current list
        final current = messagesState.value.asData?.value ?? [];
        final merged = [...current, ...nextModel.elements];
        messagesState.value = AsyncValue.data(merged);
      } on Object catch (e, st) {
        messagesState.value = AsyncValue.error(e, st);
      }
    }

    // only once on first build
    useEffect(
      () {
        fetchMessages();
        return null;
      },
      [],
    );

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
        final current = messagesState.value.asData?.value ?? [];
        messagesState.value = AsyncValue.data([...current, createdModel]);
      }).onFailure<Exception>((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message: $error')),
        );
      });
    }

    // file attachment
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

    // tap message on link or file
    Future<void> handleMessageTap(BuildContext _, types.Message message) async {
      if (message is! types.FileMessage) {
        return;
      }

      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        // Start downloading
        // You can update here if you want to display the download in progress
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
          // Finally, if you want localPath to be the uri of the message,
          // update the corresponding message in messagesState.value
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

      // open file
      await OpenFilex.open(localPath);
    }

    // preview link
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

    // send message
    void handleSendPressed(types.PartialText message) {
      final textMessage = types.TextMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: message.text,
      );
      addMessage(textMessage);
    }

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
            // TODO(referctoring): need to implement theme cosutom
            theme: const DefaultChatTheme(
              // inputPadding: EdgeInsets.all(32),
              inputBorderRadius: BorderRadius.vertical(
                top: Radius.circular(5),
              ),
              inputTextColor: Colors.black,
              inputTextStyle: TextStyle(
                // color: Colors.black,
                // fontSize: 16,
                height: 2.5,
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

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

  types.Message _decodeToTypesMessage(String rawMessageJson) {
    final json = jsonDecode(rawMessageJson) as Map<String, dynamic>;
    return types.Message.fromJson(json);
  }
}

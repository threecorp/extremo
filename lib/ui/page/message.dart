import 'dart:convert';
import 'dart:io';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/usecase/message.dart';
import 'package:extremo/io/repo/extremo/mypage.dart';
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
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

class MessagePage extends HookConsumerWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      home: ChatPage(),
    );
  }
}

class ChatPage extends HookConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesProvider = ref.watch(listPagerMessagesCaseProvider);
    final messagesNotifier = ref.watch(listPagerMessagesCaseProvider.notifier);
    final user = const types.User(
      id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
    );

    useEffect(
      () {
        messagesNotifier.loadListNextPage();
      },
      [],
    );

    void _addMessage(types.Message message) {
      final messageModel = MessageModel.fromChatMessage(chat: message);
      messagesNotifier.state = AsyncValue.data(
        [messageModel, ...messagesNotifier.state.value ?? []],
      );
    }

    void _handleAttachmentPressed() {
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
                    _handleImageSelection(_addMessage, user);
                  },
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection(_addMessage, user);
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

    void _handleMessageTap(BuildContext _, types.Message message) async {
      if (message is types.FileMessage) {
        var localPath = message.uri;

        if (message.uri.startsWith('http')) {
          try {
            final index = messagesNotifier.state.value!
                .indexWhere((element) => element.id == message.id);
            // 更新処理
            final updatedMessageModel =
                messagesNotifier.state.value![index].copyWith(
              message: jsonEncode(message.copyWith(uri: localPath).toJson()),
            );

            messagesNotifier.state = AsyncValue.data(
                List.from(messagesNotifier.state.value!)
                  ..[index] = updatedMessageModel);

            final client = http.Client();
            final request = await client.get(Uri.parse(message.uri));
            final bytes = request.bodyBytes;
            final documentsDir =
                (await getApplicationDocumentsDirectory()).path;
            localPath = '$documentsDir/${message.name}';

            if (!File(localPath).existsSync()) {
              final file = File(localPath);
              await file.writeAsBytes(bytes);
            }
          } finally {
            final index = messagesNotifier.state.value!
                .indexWhere((element) => element.id == message.id);
            final updatedMessageModel =
                messagesNotifier.state.value![index].copyWith(
              message: jsonEncode(message.toJson()),
            );

            messagesNotifier.state = AsyncValue.data(
                List.from(messagesNotifier.state.value!)
                  ..[index] = updatedMessageModel);
          }
        }

        await OpenFilex.open(localPath);
      }
    }

    void _handlePreviewDataFetched(
        types.TextMessage message, types.PreviewData previewData) {
      final index = messagesNotifier.state.value!
          .indexWhere((element) => element.id == message.id);
      final updatedMessageModel = messagesNotifier.state.value![index].copyWith(
        message:
            jsonEncode(message.copyWith(previewData: previewData).toJson()),
      );

      messagesNotifier.state = AsyncValue.data(
          List.from(messagesNotifier.state.value!)
            ..[index] = updatedMessageModel);
    }

    void _handleSendPressed(types.PartialText message) {
      final textMessage = types.TextMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: message.text,
      );

      _addMessage(textMessage);
    }

    return Scaffold(
      body: messagesProvider.when(
        data: (messageModels) {
          final messages = messageModels
              .map((m) => types.Message.fromJson(
                  jsonDecode(m.message) as Map<String, dynamic>))
              .toList();
          return Chat(
            messages: messages,
            onAttachmentPressed: _handleAttachmentPressed,
            onMessageTap: _handleMessageTap,
            onPreviewDataFetched: _handlePreviewDataFetched,
            onSendPressed: _handleSendPressed,
            showUserAvatars: true,
            showUserNames: true,
            user: user,
            theme: const DefaultChatTheme(
              seenIcon: Text(
                'read',
                style: TextStyle(
                  fontSize: 10.0,
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

  Future<void> _handleFileSelection(
      void Function(types.Message) addMessage, types.User user) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

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
      void Function(types.Message) addMessage, types.User user) async {
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
}

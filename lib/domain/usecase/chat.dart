// import 'package:collection/collection.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:result_dart/functions.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/model/pager.dart';

import 'package:extremo/io/repo/extremo/mypage/chat.dart';
import 'package:extremo/io/repo/extremo/mypage/chat_message.dart';
import 'package:extremo/misc/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat.g.dart';

class ChatUseCase {
  ChatUseCase(this.ref);

  final Ref ref;

  Future<List<ChatModel>> listChats({
    required int page,
    required int pageSize,
  }) async {
    logger.d('Request: page=$page pageSize=$pageSize');

    final pager = await ref.read(repoListPagerChatsProvider(page, pageSize).future);
    final items = pager.elements.map((entity) => ChatModel.fromEntity(entity: entity)).toList();

    logger.d('Fetched ${items.length} items ${pager.totalSize} total size for page=$page');
    return items;
  }
}

@riverpod
ChatUseCase chatUseCase(ChatUseCaseRef ref) {
  return ChatUseCase(ref);
}

//
// Message
//

class ChatMessageUseCase {
  ChatMessageUseCase(this.ref);

  final Ref ref;

  Future<NextModel<ChatMessageModel>> listChatMessages({
    required int chatFk,
    required int clientFk,
    required int next,
  }) async {
    logger.d('Request: chatFk=$chatFk clientFk=$clientFk next=$next');
    final pager = await ref.read(repoListPagerChatMessagesProvider(chatFk, clientFk, next).future);

    logger.d('Fetched ${pager.elements.length} items for next=$next');
    return NextModel<ChatMessageModel>(
      elements: pager.elements.map((entity) => ChatMessageModel.fromEntity(entity: entity)).toList(),
      next: pager.next,
    );
  }

  Future<Result<ChatMessageModel, Exception>> replyChatMessage(
    ChatMessageModel model,
  ) async {
    final result = await ref.read(
      repoReplyChatMessageProvider(model.toEntity()).future,
    );

    return result.map((e) => ChatMessageModel.fromEntity(entity: e));
  }
}

@riverpod
ChatMessageUseCase chatMessageUseCase(ChatMessageUseCaseRef ref) {
  return ChatMessageUseCase(ref);
}

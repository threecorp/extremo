// import 'package:collection/collection.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:result_dart/functions.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/io/repo/extremo/mypage/chat.dart';
import 'package:extremo/misc/logger.dart';
import 'package:result_dart/result_dart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat.g.dart';

@riverpod
class ListPagerChatsCase extends _$ListPagerChatsCase {
  int _page = 1; // TODO(refactoring): Remove build by using state
  int _pageSize = 25;
  bool _isLast = false;

  void loadListNextPage() {
    _page++;
    build();
  }

  set pageSize(int pageSize) {
    _pageSize = pageSize;
  }

  bool get isLast {
    return _isLast;
  }

  @override
  Future<List<ChatModel>> build() async {
    final pager = await ref.read(
      repoListPagerChatsProvider(_page, _pageSize).future,
    );

    final models = pager.elements.map(
      (entity) => ChatModel.fromEntity(entity: entity),
    );

    _isLast = pager.elements.length < _pageSize;

    final rr = models.toList();
    state = AsyncValue.data([...state.value ?? [], ...rr]);
    return rr;
  }

  Future<Result<ChatModel, Exception>> createChat(
    ChatModel message,
  ) async {
    final result = await ref.read(
      repoCreateChatProvider(message.toEntity()).future,
    );

    return result.map((e) {
      state = AsyncValue.data([message, ...state.value ?? []]);
      return ChatModel.fromEntity(entity: e);
    });
  }
}

class ChatUserUseCase {
  ChatUserUseCase(this.ref);

  final Ref ref;

  Future<List<UserModel>> listChatUsers({
    required int pageKey,
    required int pageSize,
  }) async {
    logger.d('Request: page=$pageKey pageSize=$pageSize');

    final pager = await ref.read(repoListPagerChatUsersProvider(pageKey, pageSize).future);

    final newItems = pager.elements
        .map(
          (entity) => UserModel.fromEntity(entity: entity),
        )
        .toList();

    logger.d('Fetched ${newItems.length} items for page=$pageKey');
    return newItems;
  }
}

@riverpod
ChatUserUseCase chatUserUseCase(ChatUserUseCaseRef ref) {
  return ChatUserUseCase(ref);
}

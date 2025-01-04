// import 'package:collection/collection.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:result_dart/functions.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/io/repo/extremo/mypage/chat.dart';
import 'package:result_dart/result_dart.dart';
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

@riverpod
class ListPagerChatUsersCase extends _$ListPagerChatUsersCase {
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
  Future<List<UserModel>> build() async {
    final pager = await ref.read(
      repoListPagerChatUsersProvider(_page, _pageSize).future,
    );

    final models = pager.elements.map(
      (entity) => UserModel.fromEntity(entity: entity),
    );

    _isLast = pager.elements.length < _pageSize;

    final rr = models.toList();
    state = AsyncValue.data([...state.value ?? [], ...rr]);
    return rr;
  }
}

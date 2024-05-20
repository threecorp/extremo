import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/io/repo/extremo/mypage.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message.g.dart';

@riverpod
class ListPagerMessagesCase extends _$ListPagerMessagesCase {
  int _page = 1; // TODO: Remove build by using state
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
  Future<List<MessageModel>> build() async {
    final pager = await ref.read(
      repoListPagerMessagesProvider(_page, _pageSize).future,
    );

    final models = pager.elements.map(
      (entity) => MessageModel.fromEntity(entity: entity),
    );

    _isLast = pager.elements.length < _pageSize;

    final rr = models.toList();
    state = AsyncValue.data([...state.value ?? [], ...rr]);
    return rr;
  }

  Future<Result<MessageModel, Exception>> createMessage(
    MessageModel message,
  ) async {
    final result = await ref.read(
      repoCreateMessageProvider(message.toEntity()).future,
    );

    return result.map((e) {
      state = AsyncValue.data([message, ...state.value ?? []]);
      return MessageModel.fromEntity(entity: e);
    });
  }
}

import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/io/repo/extremo/mypage.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// import './util.dart';

part 'message.g.dart';

// TODO(ClassBase): Transform to Class base

@riverpod
class ListPagerMessagesCase extends _$ListPagerMessagesCase {
  int _page = 1; // TODO(Refactoring): Remove build by using state
  int _pageSize = 25;
  bool _isLast = false;

  void loadListNextPage() {
    _page++; // TODO(Refactoring): Remove build by using state
    build();
  }

  // ignore: use_setters_to_change_properties
  void setPageSize(int pageSize) {
    _pageSize = pageSize; // TODO(Refactoring): Remove build by using state
  }

  bool isLast() {
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

    // TODO(Unuse): pager.totalSize
    _isLast = pager.elements.length < _pageSize;

    final rr = models.toList();
    state = AsyncValue.data([...state.value ?? [], ...rr]);
    return rr;
  }
}
//
//
//

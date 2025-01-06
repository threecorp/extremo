// import 'package:collection/collection.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:result_dart/functions.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/model/pager.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/io/repo/extremo/mypage/user.dart';
import 'package:extremo/misc/logger.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.g.dart';

@riverpod
class ListPagerUsersCase extends _$ListPagerUsersCase {
  /// Returns an “empty state (initial)” as the initial value here,
  /// The actual fetching of the first page is left to `refreshFirstPage()` and so on.
  /// If you want to get the page automatically the first time, you can await _fetchPage(PaginationState<UserModel>.initial()) and return it.
  @override
  FutureOr<PaginationState<UserModel>> build() async {
    // return PaginationState<UserModel>.initial();
    return _fetchPage(PaginationState<UserModel>.initial());
  }

  /// Page fetch method for internal use.
  /// Refer to page / pageSize, etc. in [stateBeforeFetch], hit API, and return composite results.
  Future<PaginationState<UserModel>> _fetchPage(PaginationState<UserModel> stateBeforeFetch) async {
    logger.d('Request: page=${stateBeforeFetch.page} pageSize=${stateBeforeFetch.pageSize}');

    final pager = await ref.read(
      repoListPagerUsersProvider(stateBeforeFetch.page, stateBeforeFetch.pageSize).future,
    );

    // Convert API results to UserModel
    final newItems = pager.elements.map((entity) => UserModel.fromEntity(entity: entity)).toList();
    // Determine if this is the last page
    final isLast = newItems.length < stateBeforeFetch.pageSize;

    // Add to existing list and return
    final newState = stateBeforeFetch.copyWithMergedItems(
      newItems: newItems,
      isLast: isLast,
    );

    logger.d('isLast: $isLast, totalItems: ${newState.items.length}');
    return newState;
  }

  /// Paging to load the next page
  Future<void> loadNextPage() async {
    // Wait if the current state is still being read (AsyncValue.guard, etc. is OK)
    final currentState = await _ensureLoadedState();

    if (currentState.isLast) {
      logger.d('Already isLast, no more pages to load');
      return;
    }

    // Get next page and update state
    state = const AsyncValue.loading();
    final newState = await _fetchPage(currentState.copyWithNextPage());
    state = AsyncValue.data(newState);
  }

  /// Reload the very first page.
  Future<void> refreshFirstPage() async {
    state = const AsyncValue.loading();
    final newState = await _fetchPage(PaginationState<UserModel>.initial());
    state = AsyncValue.data(newState);
  }

  /// Helper to safely retrieve the current [state] with `Future<PaginationState<UserModel>>`.
  Future<PaginationState<UserModel>> _ensureLoadedState() async {
    // If state is still unloaded or in error, `build()` and load it again.
    final value = state.valueOrNull ?? await future;
    return value;
  }
}

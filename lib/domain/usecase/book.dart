// import 'package:collection/collection.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:result_dart/functions.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:collection/collection.dart';
import 'package:extremo/domain/model/pager.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/io/repo/extremo/mypage/book.dart';
import 'package:extremo/misc/logger.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book.g.dart';

@riverpod
class ListPagerBooksCase extends _$ListPagerBooksCase {
  /// Returns an “empty state (initial)” as the initial value here,
  /// The actual fetching of the first page is left to `refreshFirstPage()` and so on.
  /// If you want to get the page automatically the first time, you can await _fetchPage(PaginationState<BookModel>.initial()) and return it.
  @override
  FutureOr<PaginationState<BookModel>> build() async {
    // return PaginationState<BookModel>.initial();
    return _fetchPage(PaginationState<BookModel>.initial());
  }

  /// Page fetch method for internal use.
  /// Refer to page / pageSize, etc. in [stateBeforeFetch], hit API, and return composite results.
  Future<PaginationState<BookModel>> _fetchPage(PaginationState<BookModel> stateBeforeFetch) async {
    final account = ref.read(accountProvider.notifier).account();
    final tenantFk = account?.tenantFk;
    if (tenantFk == null) {
      throw Exception('Tenant is required but not available');
    }

    logger.d('Request: page=${stateBeforeFetch.page} pageSize=${stateBeforeFetch.pageSize}');

    final pager = await ref.read(
      repoListPagerBooksProvider(stateBeforeFetch.page, stateBeforeFetch.pageSize).future,
    );

    // Convert API results to BookModel
    final newItems = pager.elements.map((entity) => BookModel.fromEntity(entity: entity)).toList();
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
    final newState = await _fetchPage(PaginationState<BookModel>.initial());
    state = AsyncValue.data(newState);
  }

  /// Helper to safely retrieve the current [state] with `Future<PaginationState<BookModel>>`.
  Future<PaginationState<BookModel>> _ensureLoadedState() async {
    // If state is still unloaded or in error, `build()` and load it again.
    final value = state.valueOrNull ?? await future;
    return value;
  }
}

@riverpod
Future<List<BookModel>> filterBooksCase(
  FilterBooksCaseRef ref,
) async {
  final result = await ref.read(repoFilterBooksProvider.future);
  return result.map((e) => BookModel.fromEntity(entity: e)).toList();
}

@riverpod
Future<Result<BookModel, Exception>> getBookCase(
  GetBookCaseRef ref,
  int id,
) async {
  final result = await ref.read(repoGetBookProvider(id).future);
  return result.map((e) => BookModel.fromEntity(entity: e));
}

@riverpod
Future<Result<BookModel, Exception>> createBookCase(
  CreateBookCaseRef ref,
  BookModel model,
  List<int> clientFks,
  List<int> teamFks,
  List<int> serviceFks,
) async {
  final result = await ref.read(
    repoCreateBookProvider(model.toEntity(), clientFks, teamFks, serviceFks).future,
  );

  return result.map((e) => BookModel.fromEntity(entity: e));
}

@riverpod
Future<Result<BookModel, Exception>> updateBookCase(
  UpdateBookCaseRef ref,
  BookModel model,
  List<int> clientFks,
  List<int> teamFks,
  List<int> serviceFks,
) async {
  final result = await ref.read(
    repoUpdateBookProvider(model.toEntity(), clientFks, teamFks, serviceFks).future,
  );

  return result.map((e) => BookModel.fromEntity(entity: e));
}

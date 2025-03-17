/// Class that summarizes the paging state.
/// - `page`: The current page number.
/// - `pageSize`: Number of elements per page.
/// - `isLast`: last page or not.
/// - `items`: list of retrieved users
class PaginationState<T> {
  const PaginationState({
    required this.page,
    required this.pageSize,
    required this.isLast,
    required this.items,
  });

  /// Empty initial state (page = 1, isLast = false, items = [], etc.)
  factory PaginationState.initial({int pageSize = 25}) {
    return PaginationState(
      page: 1,
      pageSize: pageSize,
      isLast: false,
      items: const [],
    );
  }

  final int page;
  final int pageSize;
  final bool isLast;
  final List<T> items;

  /// Advance to the next page.
  PaginationState<T> copyWithNextPage() {
    return PaginationState(
      page: page + 1,
      pageSize: pageSize,
      isLast: isLast,
      items: items,
    );
  }

  /// Merge the new listing and update `isLast` as well.
  PaginationState<T> copyWithMergedItems({
    required List<T> newItems,
    required bool isLast,
  }) {
    return PaginationState(
      page: page,
      pageSize: pageSize,
      isLast: isLast,
      items: [...items, ...newItems],
    );
  }
}

class NextModel<T> {
  NextModel({required this.elements, required this.next});

  final List<T> elements;
  final int next;
}

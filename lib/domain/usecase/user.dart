// import 'package:collection/collection.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:result_dart/functions.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/io/repo/extremo/mypage/user.dart';
import 'package:extremo/misc/logger.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.g.dart';

/// ページング状態をまとめたクラス。
/// - `page`: 現在のページ番号
/// - `pageSize`: 1ページあたりの要素数
/// - `isLast`: 最終ページかどうか
/// - `items`: 取得済みのユーザ一覧
class UserPaginationState {
  final int page;
  final int pageSize;
  final bool isLast;
  final List<UserModel> items;

  const UserPaginationState({
    required this.page,
    required this.pageSize,
    required this.isLast,
    required this.items,
  });

  /// 空の初期状態（ページ = 1, isLast = false, items = []など）
  factory UserPaginationState.initial({int pageSize = 25}) {
    return UserPaginationState(
      page: 1,
      pageSize: pageSize,
      isLast: false,
      items: const [],
    );
  }

  /// 次のページへ進む。
  UserPaginationState copyWithNextPage() {
    return UserPaginationState(
      page: page + 1,
      pageSize: pageSize,
      isLast: isLast,
      items: items,
    );
  }

  /// 新たなリストをマージして `isLast` も更新。
  UserPaginationState copyWithMergedItems({
    required List<UserModel> newItems,
    required bool isLast,
  }) {
    return UserPaginationState(
      page: page,
      pageSize: pageSize,
      isLast: isLast,
      items: [...items, ...newItems],
    );
  }
}

@riverpod
class ListPagerUsersCase extends _$ListPagerUsersCase {
  /// 初期値として1ページ目を読み込む(またはまだ読み込んでいない状態にする)。
  @override
  FutureOr<UserPaginationState> build() async {
    // ここで1ページ目を取得して返す or 空状態を返して
    // 初回読み込みを別メソッドに任せる…などいろいろパターンがあります。
    // 例: build時に即fetchする
    return _fetchPage(UserPaginationState.initial());
  }

  /// 内部用のページ取得メソッド。
  /// [stateBeforeFetch] の page / pageSize などを参照してAPIを叩き、結果を合成して返す。
  Future<UserPaginationState> _fetchPage(
    UserPaginationState stateBeforeFetch,
  ) async {
    final account = ref.read(accountProvider.notifier).account();
    final tenantFk = account?.tenantFk;
    if (tenantFk == null) {
      throw Exception('Tenant is required but not available');
    }

    logger.d('Request: page=${stateBeforeFetch.page} pageSize=${stateBeforeFetch.pageSize}');

    final pager = await ref.read(
      repoListPagerUsersProvider(tenantFk, stateBeforeFetch.page, stateBeforeFetch.pageSize).future,
    );

    // APIの取得結果を UserModel に変換
    final newItems = pager.elements.map((entity) => UserModel.fromEntity(entity: entity)).toList();

    final isLast = newItems.length < stateBeforeFetch.pageSize;

    // 既存のリストに追加して返す
    final newState = stateBeforeFetch.copyWithMergedItems(
      newItems: newItems,
      isLast: isLast,
    );

    logger.d('isLast: $isLast, totalItems: ${newState.items.length}');
    return newState;
  }

  /// ページングで次のページを読み込む
  Future<void> loadNextPage() async {
    // 現在の state がまだ読み込み途中なら待つ（AsyncValue.guard などでもOK）
    final currentState = await _ensureLoadedState(); // 下のヘルパーメソッド

    // すでに最後のページなら何もしない
    if (currentState.isLast) {
      logger.d('Already isLast, no more pages to load');
      return;
    }

    // 次ページを取得して state 更新
    state = const AsyncValue.loading(); // ローディング状態にしてもいいし、そのままでも良い
    final newState = await _fetchPage(currentState.copyWithNextPage());
    state = AsyncValue.data(newState);
  }

  /// 一番最初のページを再読み込みする。
  Future<void> refreshFirstPage() async {
    state = const AsyncValue.loading();
    final newState = await _fetchPage(UserPaginationState.initial());
    state = AsyncValue.data(newState);
  }

  /// 現在の [state] を `Future<UserPaginationState>` で安全に取得するためのヘルパー。
  Future<UserPaginationState> _ensureLoadedState() async {
    // もし state がまだ未読み込みやエラーの場合は `build()` し直してロード。
    final value = state.valueOrNull ?? await future;
    return value;
  }
}

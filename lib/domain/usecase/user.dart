import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/model/pager.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/io/repo/extremo/mypage/user.dart';
import 'package:extremo/misc/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.g.dart';

class UserUseCase {
  UserUseCase(this.ref);

  final Ref ref;

  Future<List<UserModel>> fetchUserPage({
    required int pageKey,
    required int pageSize,
  }) async {
    logger.d('Request: page=$pageKey pageSize=$pageSize');

    final pager = await ref.read(repoListPagerUsersProvider(pageKey, pageSize).future);

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
UserUseCase userUseCase(UserUseCaseRef ref) {
  return UserUseCase(ref);
}

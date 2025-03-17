// import 'package:collection/collection.dart';
// import 'package:result_dart/functions.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/model/pager.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/io/repo/extremo/mypage/team.dart';
import 'package:extremo/misc/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'team.g.dart';

class TeamUseCase {
  TeamUseCase(this.ref);

  final Ref ref;

  Future<List<TeamModel>> listTeams({
    required int page,
    required int pageSize,
  }) async {
    logger.d('Request: page=$page pageSize=$pageSize');

    final pager = await ref.read(repoListPagerTeamsProvider(page, pageSize).future);

    final items = pager.elements
        .map(
          (entity) => TeamModel.fromEntity(entity: entity),
        )
        .toList();

    logger.d('Fetched ${items.length} items ${pager.totalSize} total size for page=$page');
    return items;
  }
}

@riverpod
TeamUseCase teamUseCase(TeamUseCaseRef ref) {
  return TeamUseCase(ref);
}

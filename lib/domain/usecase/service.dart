// import 'package:collection/collection.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:result_dart/functions.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/model/pager.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/io/repo/extremo/mypage/service.dart';
import 'package:extremo/misc/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service.g.dart';

class ServiceUseCase {
  ServiceUseCase(this.ref);

  final Ref ref;

  Future<List<ServiceModel>> fetchServicePage({
    required int pageKey,
    required int pageSize,
  }) async {
    logger.d('Request: page=$pageKey pageSize=$pageSize');

    final pager = await ref.read(repoListPagerServicesProvider(pageKey, pageSize).future);

    final newItems = pager.elements
        .map(
          (entity) => ServiceModel.fromEntity(entity: entity),
        )
        .toList();

    logger.d('Fetched ${newItems.length} items for page=$pageKey');
    return newItems;
  }
}

@riverpod
ServiceUseCase serviceUseCase(ServiceUseCaseRef ref) {
  return ServiceUseCase(ref);
}

// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:extremo/io/entity/extremo.dart';
import 'package:extremo/io/store/api/extremo/extremo.dart';
import 'package:extremo/io/store/db/extremo/extremo_box.dart';
import 'package:extremo/misc/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'extremo.g.dart';

// TODO: Transform to Class base

@riverpod
Future<List<ExtremoUserEntity>> dbListExtremoUsersByIds(
  DbListExtremoUsersByIdsRef ref,
  List<int> ids,
) async {
  final box = await ref.read(extremoUserBoxProvider.future);
  final api = ref.read(extremoPublicApiProvider);

  Future<ExtremoUserEntity?> getter(int id) async {
    final entity = box.get(id);
    if (entity != null) {
      return entity;
    }

    final response = await api.getUser(id);
    final result = ExtremoUserEntity.from(element: response.element);

    await box.put(id, result);
    return result;
  }

  return Future.wait(ids.map((id) => getter(id).onNotFoundErrorToNull()))
      .then((list) => list.whereType<ExtremoUserEntity>().toList());
}

@riverpod
Future<List<ExtremoArtifactEntity>> dbListPagerExtremoArtifacts(
  DbListPagerExtremoArtifactsRef ref, {
  int page = 1,
  int pageSize = 25,
}) async {
  final box = await ref.read(extremoArtifactBoxProvider.future);
  final api = ref.read(extremoMypageApiProvider);

  final response = await api.listArtifacts(page, pageSize);
  final elements = response.elements.map((elm) {
    final entity = ExtremoArtifactEntity.from(element: elm);
    if (box.get(elm.pk)?.updatedAt == entity.updatedAt) {
      return entity;
    }

    box.put(elm.pk, entity);
    return entity;
  });

  return elements.toList();
}

//
//
//

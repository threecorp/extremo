import 'package:collection/collection.dart';
import 'package:extremo/io/entity/extremo/extremo.dart';
import 'package:extremo/io/entity/paging.dart';
import 'package:extremo/io/store/api/extremo/extremo.dart';
import 'package:extremo/io/store/db/extremo/extremo_box.dart';
import 'package:extremo/misc/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'extremo.g.dart';

// TODO(ClassBase): Transform to Class base

@riverpod
Future<List<UserEntity>> dbListUsersByIds(
  DbListUsersByIdsRef ref,
  List<int> ids,
) async {
  final userBox = await ref.read(userBoxProvider.future);
  final publicApi = ref.read(publicApiProvider);

  Future<UserEntity?> getter(int id) async {
    final entity = userBox.get(id);
    if (entity != null) {
      return entity;
    }

    final response = await publicApi.getUser(id);
    final result = UserEntity.from(element: response.element);

    await userBox.put(id, result);
    return result;
  }

  return Future.wait(ids.map((id) => getter(id).onNotFoundErrorToNull()))
      .then((list) => list.whereType<UserEntity>().toList());
}

@riverpod
Future<PagingEntity<ArtifactEntity>> dbListPagerArtifacts(
  DbListPagerArtifactsRef ref,
  int page,
  int pageSize,
) async {
  final artifactBox = await ref.read(artifactBoxProvider.future);
  final userBox = await ref.read(userBoxProvider.future);
  final mypageApi = ref.read(mypageApiProvider);

  final response = await mypageApi.listArtifacts(page, pageSize);
  final elements = response.elements.map((elm) {
    final entity = ArtifactEntity.from(element: elm);
    if (artifactBox.get(elm.pk)?.updatedAt == entity.updatedAt) {
      return entity;
    }

    // Artifact
    artifactBox.put(elm.pk, entity);
    // User
    if (entity.user != null) {
      userBox.put(entity.userFk, entity.user!);
    }

    return entity;
  });

  return PagingEntity<ArtifactEntity>(
    elements: elements.toList(),
    totalSize: response.totalSize,
  );
}

//
//
//

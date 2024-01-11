// import 'package:extremo/io/store/api/extremo/extremo_response.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:extremo/io/entity/extremo/extremo.dart';
import 'package:extremo/io/entity/paging.dart';
import 'package:extremo/io/store/api/extremo/extremo.dart';
import 'package:extremo/io/store/api/extremo/extremo_request.dart';
import 'package:extremo/io/store/db/extremo/extremo_box.dart';
import 'package:extremo/io/x/extremo/extremo.dart';
import 'package:extremo/misc/result.dart';
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
  final mypageApi = ref.read(mypageApiProvider);

  // TODO(offline): Use DBCache when offlined or error
  final response = await mypageApi.listArtifacts(page, pageSize);
  final elements = await Future.wait(
    response.elements.map(
      (element) => xFormArtifactEntity(ref, element),
    ),
  );

  return PagingEntity<ArtifactEntity>(
    elements: elements.toList(),
    totalSize: response.totalSize,
  );
}

@riverpod
Future<ArtifactEntity> dbCreateArtifact(
  DbCreateArtifactRef ref,
  ArtifactEntity request,
) async {
  final mypageApi = ref.read(mypageApiProvider);

  final response = await mypageApi.createArtifact(
    ArtifactRequest(
      title: request.title,
      summary: request.summary,
      content: request.content,
      publishFrom: request.publishFrom,
      publishUntil: request.publishUntil,
    ),
  );

  return xFormArtifactEntity(ref, response.element);
}
//
//
//

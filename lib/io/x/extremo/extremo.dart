// import 'package:extremo/io/entity/paging.dart';
// import 'package:extremo/io/store/api/extremo/extremo.dart';
// import 'package:extremo/io/store/api/extremo/extremo_request.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';
import 'package:extremo/io/entity/extremo/extremo.dart';
import 'package:extremo/io/store/api/extremo/extremo_response.dart';
import 'package:extremo/io/store/db/extremo/extremo_box.dart';
import 'package:extremo/misc/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Cache save & return
Future<ArtifactEntity> xFormArtifactEntity(
  Ref ref,
  ArtifactResponse element,
) async {
  final artifactBox = await ref.read(artifactBoxProvider.future);
  final userBox = await ref.read(userBoxProvider.future);

  final entity = ArtifactEntity.from(element: element);
  if (artifactBox.get(element.pk)?.updatedAt == entity.updatedAt) {
    return entity;
  }

  //
  // TODO(Backgrounder): Background process to put data to DB
  //
  // Artifact
  await artifactBox.put(element.pk, entity);
  // User
  if (entity.user != null) {
    await userBox.put(entity.userFk, entity.user!);
  }

  return entity;
}
//
//
//

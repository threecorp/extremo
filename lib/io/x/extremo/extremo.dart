// import 'package:extremo/io/entity/paging.dart';
// import 'package:extremo/io/store/api/extremo/extremo.dart';
// import 'package:extremo/io/store/api/extremo/extremo_request.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';
import 'package:extremo/io/entity/extremo/extremo.dart';
import 'package:extremo/io/store/api/extremo/extremo_response.dart';
import 'package:extremo/io/store/db/extremo/box.dart';
import 'package:extremodart/extremo/api/mypage/artifacts/v1/artifact_service.pb.dart';
import 'package:extremodart/extremo/msg/db/v1/db.pb.dart' as pbdb;
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Cache save & return
Future<ArtifactEntity> xFormResponseArtifactEntity(
  Ref ref,
  ArtifactResponse element,
) async {
  final artifactBox = await ref.read(artifactBoxProvider.future);
  final userBox = await ref.read(userBoxProvider.future);

  final entity = ArtifactEntity.fromResponse(element: element);
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

// Cache save & return
Future<ArtifactEntity> xFormRpcArtifactEntity(
  Ref ref,
  pbdb.Artifact element,
) async {
  final artifactBox = await ref.read(artifactBoxProvider.future);
  final userBox = await ref.read(userBoxProvider.future);

  final entity = ArtifactEntity.fromRpc(element: element);
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

// Cache save & return
Future<MessageEntity> xFormRpcMessageEntity(
  Ref ref,
  pbdb.Message element,
) async {
  final messageBox = await ref.read(messageBoxProvider.future);
  final userBox = await ref.read(userBoxProvider.future);

  final entity = MessageEntity.fromRpc(element: element);
  if (messageBox.get(element.pk)?.updatedAt == entity.updatedAt) {
    return entity;
  }

  //
  // TODO(Backgrounder): Background process to put data to DB
  //
  // Message
  await messageBox.put(element.pk, entity);
  // User
  if (entity.fromUser != null) {
    await userBox.put(entity.fromFk, entity.fromUser!);
  }
  if (entity.toUser != null) {
    await userBox.put(entity.toFk, entity.toUser!);
  }

  return entity;
}

//
//
//

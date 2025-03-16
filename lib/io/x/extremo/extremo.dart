// import 'package:extremo/io/entity/paging.dart';
// import 'package:extremo/io/store/api/extremo/extremo.dart';
// import 'package:extremo/io/store/api/extremo/extremo_request.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';
import 'package:extremo/misc/logger.dart';
import 'package:collection/collection.dart';
import 'package:extremo/io/entity/extremo/extremo.dart';
import 'package:extremo/io/store/api/extremo/extremo_response.dart';
import 'package:extremo/io/store/db/extremo/box.dart';
import 'package:extremodart/extremo/api/mypage/artifacts/v1/artifact_service.pb.dart';
import 'package:extremodart/extremo/msg/db/v1/db.pb.dart' as pbdb;
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Cache save & return
Future<ArtifactEntity> xFormRpcArtifactEntity(
  Ref ref,
  pbdb.Artifact element,
) async {
  final artifactBox = await ref.read(artifactBoxProvider.future);
  // final userBox = await ref.read(userBoxProvider.future);

  final entity = ArtifactEntity.fromRpc(element: element);
  if (artifactBox.get(element.pk)?.updatedAt == entity.updatedAt) {
    return entity;
  }

  //
  // XXX(Caution): unawaited, Background process to put data to DB
  // TODO(compaction): compare to both of updatedAt
  //
  unawaited(artifactBox.put(element.pk, entity));

  // if (entity.user != null) {
  //   unawaited(userBox.put(entity.userFk, entity.user!));
  // }

  return entity;
}

// Cache save & return
Future<ChatEntity> xFormRpcChatEntity(
  Ref ref,
  pbdb.Chat element,
) async {
  // final tenantBox = await ref.read(tenantBoxProvider.future);
  // final userBox = await ref.read(userBoxProvider.future);
  final chatBox = await ref.read(chatBoxProvider.future);

  final entity = ChatEntity.fromRpc(element: element);
  if (chatBox.get(element.pk)?.updatedAt == entity.updatedAt) {
    return entity;
  }

  //
  // XXX(Caution): unawaited, Background process to put data to DB
  // TODO(compaction): compare to both of updatedAt
  //
  unawaited(chatBox.put(element.pk, entity));

  // if (entity.recipientUser != null) {
  //   unawaited(userBox.put(entity.recipientFk, entity.recipientUser!));
  // }
  // if (entity.tenant != null) {
  //   unawaited(tenantBox.put(entity.tenantFk, entity.tenant!));
  // }

  return entity;
}

// Cache save & return
Future<UserEntity> xFormRpcChatUserEntity(
  Ref ref,
  pbdb.User element,
) async {
  // final chatBox = await ref.read(chatBoxProvider.future);
  // final userBox = await ref.read(userBoxProvider.future);

  final entity = UserEntity.fromRpc(element: element);
  // if (chatBox.get(element.pk)?.updatedAt == entity.updatedAt) {
  //   return entity;
  // }
  //
  //
  // XXX(Caution): unawaited, Background process to put data to DB
  // TODO(compaction): compare to both of updatedAt
  //
  // // Chat
  // await chatBox.put(element.pk, entity);
  // // User
  // if (entity.recipientUser != null) {
  //   await userBox.put(entity.recipientFk, entity.recipientUser!);
  // }

  return entity;
}

// Cache save & return
Future<UserEntity> xFormRpcUserEntity(
  Ref ref,
  pbdb.User element,
) async {
  // final tenantBox = await ref.read(tenantBoxProvider.future);
  final userBox = await ref.read(userBoxProvider.future);
  // final userProfileBox = await ref.read(userProfileBoxProvider.future);

  final entity = UserEntity.fromRpc(element: element);
  if (userBox.get(element.pk)?.updatedAt == entity.updatedAt) {
    return entity;
  }

  //
  // XXX(Caution): unawaited, Background process to put data to DB
  // TODO(compaction): compare to both of updatedAt
  //
  unawaited(userBox.put(element.pk, entity));

  // if (entity.profile != null) {
  //   unawaited(userProfileBox.put(entity.profile!.pk, entity.profile!));
  // }
  // if (entity.tenant != null) {
  //   unawaited(tenantBox.put(entity.tenantFk, entity.tenant!));
  // }

  return entity;
}

// Cache save & return
Future<ServiceEntity> xFormRpcServiceEntity(
  Ref ref,
  pbdb.Service element,
) async {
  // final tenantBox = await ref.read(tenantBoxProvider.future);
  final serviceBox = await ref.read(serviceBoxProvider.future);

  final entity = ServiceEntity.fromRpc(element: element);
  if (serviceBox.get(element.pk)?.updatedAt == entity.updatedAt) {
    return entity;
  }

  //
  // XXX(Caution): unawaited, Background process to put data to DB
  //
  unawaited(serviceBox.put(element.pk, entity));

  // if (entity.tenant != null) {
  //   unawaited(tenantBox.put(entity.tenantFk, entity.tenant!));
  // }

  return entity;
}

// Cache save & return
Future<TenantEntity> xFormRpcTenantEntity(
  Ref ref,
  pbdb.Tenant element,
) async {
  final tenantBox = await ref.read(tenantBoxProvider.future);
  // final tenantProfileBox = await ref.read(tenantProfileBoxProvider.future);

  final entity = TenantEntity.fromRpc(element: element);
  if (tenantBox.get(element.pk)?.updatedAt == entity.updatedAt) {
    return entity;
  }

  //
  // XXX(Caution): unawaited, Background process to put data to DB
  //
  unawaited(tenantBox.put(element.pk, entity));

  // if (entity.profile != null) {
  //   unawaited(tenantProfileBox.put(entity.profile?.pk, entity.profile!));
  // }

  return entity;
}

// Cache save & return
Future<TeamEntity> xFormRpcTeamEntity(
  Ref ref,
  pbdb.Team element,
) async {
  final teamBox = await ref.read(teamBoxProvider.future);
  // final teamProfileBox = await ref.read(teamProfileBoxProvider.future);

  final entity = TeamEntity.fromRpc(element: element);
  if (teamBox.get(element.pk)?.updatedAt == entity.updatedAt) {
    return entity;
  }

  //
  // XXX(Caution): unawaited, Background process to put data to DB
  //
  unawaited(teamBox.put(element.pk, entity));

  // if (entity.profile != null) {
  //   unawaited(teamProfileBox.put(entity.profile?.pk, entity.profile!));
  // }

  return entity;
}

// Cache save & return
Future<BookEntity> xFormRpcBookEntity(
  Ref ref,
  pbdb.Book element,
) async {
  final bookBox = await ref.read(bookBoxProvider.future);
  // final bookProfileBox = await ref.read(bookProfileBoxProvider.future);

  final entity = BookEntity.fromRpc(element: element);
  if (bookBox.get(element.pk)?.updatedAt == entity.updatedAt) {
    return entity;
  }

  //
  // XXX(Caution): unawaited, Background process to put data to DB
  //
  unawaited(bookBox.put(element.pk, entity));

  // if (entity.profile != null) {
  //   unawaited(bookProfileBox.put(entity.profile?.pk, entity.profile!));
  // }

  return entity;
}

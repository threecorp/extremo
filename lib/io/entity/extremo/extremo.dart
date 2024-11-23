import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:extremo/io/store/api/extremo/extremo_response.dart';
import 'package:extremo/misc/logger.dart';
import 'package:extremo/misc/xcontext.dart';
import 'package:extremodart/extremo/msg/db/v1/db.pb.dart' as pbdb;
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat_types;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

part 'extremo.g.dart';

@HiveType(typeId: 1)
class UserEntity {
  UserEntity({
    required this.id,
    this.email = '',
    this.dateJoined,
    this.deletedAt,
    required this.isDeleted,
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.profile,
    this.artifacts = const [],
  });

  // factory UserEntity.fromResponse({
  //   required UserResponse element,
  // }) {
  //   final artifacts = element.artifacts
  //       .map((element) => ArtifactEntity.fromResponse(element: element))
  //       .toList();
  //   return UserEntity(
  //     id: element.pk,
  //     email: element.email ?? '',
  //     dateJoined: element.dateJoined,
  //     isDeleted: element.isDeleted,
  //     deletedAt: element.deletedAt,
  //     createdAt: element.createdAt,
  //     updatedAt: element.updatedAt,
  //     // Relationships
  //     artifacts: artifacts,
  //   );
  // }

  factory UserEntity.fromRpc({
    required pbdb.User element,
    XContext? context,
  }) {
    context ??= XContext.of();

    var entity = context.getE<UserEntity>(element.pk);
    if (entity != null) {
      return entity;
    }

    entity = UserEntity(
      id: element.pk,
      email: element.email,
      dateJoined: element.dateJoined.toDateTime(),
      isDeleted: element.isDeleted,
      deletedAt: element.deletedAt.toDateTime(),
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
      // Relationships
      // profile: profile,
      // artifacts: artifacts,
    );
    context.putE(entity.id, entity);

    entity
      ..artifacts = element.artifacts.map((e) {
        return context!.getE<ArtifactEntity>(e.pk) ??
            ArtifactEntity.fromRpc(element: e, context: context);
      }).toList()
      ..profile = element.hasProfile()
          ? UserProfileEntity.fromRpc(
              element: element.profile,
              context: context,
            )
          : null;

    return entity;
  }

  @HiveField(0)
  int id;

  @HiveField(1)
  String email;

  @HiveField(2)
  DateTime? dateJoined;

  @HiveField(3)
  bool isDeleted;

  @HiveField(4)
  DateTime? deletedAt;

  @HiveField(5)
  DateTime? createdAt;

  @HiveField(6)
  DateTime? updatedAt;

  // Relationships
  UserProfileEntity? profile;
  List<ArtifactEntity> artifacts;
}

@HiveType(typeId: 4)
class UserProfileEntity {
  UserProfileEntity({
    required this.id,
    required this.userFk,
    this.name = '',
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.user,
  });

  // factory UserProfileEntity.fromResponse({
  //   required UserResponse element,
  // }) {
  //   final user = element.user != null ?
  //   UserEntity.fromResponse(element: element))
  //
  //   return UserProfileEntity(
  //     id: element.pk,
  //     name: element.name ?? '',
  //     createdAt: element.createdAt,
  //     updatedAt: element.updatedAt,
  //     // Relationships
  //     user: user,
  //   );
  // }

  factory UserProfileEntity.fromRpc({
    required pbdb.UserProfile element,
    XContext? context,
  }) {
    context ??= XContext.of();

    var entity = context.getE<UserProfileEntity>(element.pk);
    if (entity != null) {
      return entity;
    }

    entity = UserProfileEntity(
      id: element.pk,
      userFk: element.userFk,
      name: element.name,
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
      // Relationships
      // user: null,
    );
    context.putE(entity.id, entity);

    entity.user = (context.getE<UserEntity>(element.userFk)) ??
        (element.hasUser()
            ? UserEntity.fromRpc(element: element.user, context: context)
            : null);

    return entity;
  }

  @HiveField(0)
  int id;

  @HiveField(1)
  int userFk;

  @HiveField(2)
  String name;

  @HiveField(3)
  DateTime? createdAt;

  @HiveField(4)
  DateTime? updatedAt;

  // Relationships
  UserEntity? user;
}

@HiveType(typeId: 2)
class ArtifactEntity {
  ArtifactEntity({
    required this.id,
    required this.userFk,
    this.title = '',
    this.content = '',
    this.summary = '',
    this.status = '', // TODO: Enum Type
    this.publishFrom,
    this.publishUntil,
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.user,
  });

  // factory ArtifactEntity.fromResponse({
  //   required ArtifactResponse element,
  // }) {
  //   final user = element.user != null
  //       ? UserEntity.fromResponse(element: element.user!)
  //       : null;
  //
  //   return ArtifactEntity(
  //     id: element.pk,
  //     userFk: element.userFk,
  //     title: element.title,
  //     content: element.content,
  //     summary: element.summary,
  //     status: element.status,
  //     publishFrom: element.publishFrom,
  //     publishUntil: element.publishUntil,
  //     createdAt: element.createdAt,
  //     updatedAt: element.updatedAt,
  //     // Relationships
  //     user: user,
  //   );
  // }

  factory ArtifactEntity.fromRpc({
    required pbdb.Artifact element,
    XContext? context,
  }) {
    context ??= XContext.of();

    var entity = context.getE<ArtifactEntity>(element.pk);
    if (entity != null) {
      return entity;
    }

    entity = ArtifactEntity(
      id: element.pk,
      userFk: element.userFk,
      title: element.title,
      content: element.content,
      summary: element.summary,
      status: element.status.name,
      publishFrom: element.publishFrom.toDateTime(),
      publishUntil: element.publishUntil.toDateTime(),
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
      // Relationships
      // user: user,
    );
    context.putE(entity.id, entity);

    entity.user = (context.getE<UserEntity>(element.userFk)) ??
        (element.hasUser()
            ? UserEntity.fromRpc(element: element.user, context: context)
            : null);

    return entity;
  }

  @HiveField(0)
  int id;

  @HiveField(1)
  int userFk;

  @HiveField(2)
  String title;

  @HiveField(3)
  String content;

  @HiveField(4)
  String summary;

  @HiveField(5)
  String status; // TODO: Enum Type

  @HiveField(6)
  DateTime? publishFrom;

  @HiveField(7)
  DateTime? publishUntil;

  @HiveField(8)
  DateTime? createdAt;

  @HiveField(9)
  DateTime? updatedAt;

  // Relationships
  UserEntity? user;
}

@HiveType(typeId: 3)
class MessageEntity {
  MessageEntity({
    required this.id,
    required this.fromFk,
    required this.toFk,
    this.message = '',
    required this.isRead,
    this.readAt,
    required this.isDeleted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.fromUser,
    this.toUser,
  });

  // factory MessageEntity.fromResponse({
  //   required MessageResponse element,
  // }) {
  //   final user = element.user != null
  //       ? UserEntity.fromResponse(element: element.user!)
  //       : null;
  //
  //   return MessageEntity(
  //     id: element.pk,
  //     userFk: element.userFk,
  //     title: element.title,
  //     content: element.content,
  //     summary: element.summary,
  //     status: element.status,
  //     publishFrom: element.publishFrom,
  //     publishUntil: element.publishUntil,
  //     createdAt: element.createdAt,
  //     updatedAt: element.updatedAt,
  //     // Relationships
  //     user: user,
  //   );
  // }

  factory MessageEntity.fromRpc({
    required pbdb.Message element,
    XContext? context,
  }) {
    context ??= XContext.of();

    var entity = context.getE<MessageEntity>(element.pk);
    if (entity != null) {
      return entity;
    }
    entity = MessageEntity(
      id: element.pk,
      fromFk: element.fromFk,
      toFk: element.toFk,
      message: element.message,
      isRead: element.isRead,
      readAt: element.readAt.toDateTime(),
      isDeleted: element.isDeleted,
      deletedAt: element.deletedAt.toDateTime(),
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
      // Relationships
      // fromUser: fromUser,
      // toUser: toUser,
    );
    context.putE(entity.id, entity);

    entity
      ..fromUser = (context.getE<UserEntity>(element.fromFk)) ??
          (element.hasFromUser()
              ? UserEntity.fromRpc(element: element.fromUser, context: context)
              : null)
      ..toUser = (context.getE<UserEntity>(element.toFk)) ??
          (element.hasToUser()
              ? UserEntity.fromRpc(element: element.toUser, context: context)
              : null);

    return entity;
  }

  @HiveField(0)
  int id;

  @HiveField(1)
  int fromFk;

  @HiveField(2)
  int toFk;

  @HiveField(3)
  String message;

  @HiveField(4)
  bool isRead;

  @HiveField(5)
  DateTime? readAt;

  @HiveField(6)
  bool isDeleted;

  @HiveField(7)
  DateTime? deletedAt;

  @HiveField(8)
  DateTime? createdAt;

  @HiveField(9)
  DateTime? updatedAt;

  // Relationships
  UserEntity? fromUser;
  UserEntity? toUser;
}

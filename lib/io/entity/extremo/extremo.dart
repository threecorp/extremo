import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:extremo/io/store/api/extremo/extremo_response.dart';
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
    this.artifacts = const [],
  });

  factory UserEntity.fromResponse({
    required UserResponse element,
  }) {
    final artifacts = element.artifacts
        .map((element) => ArtifactEntity.fromResponse(element: element))
        .toList();
    return UserEntity(
      id: element.pk,
      email: element.email ?? '',
      dateJoined: element.dateJoined,
      isDeleted: element.isDeleted,
      deletedAt: element.deletedAt,
      createdAt: element.createdAt,
      updatedAt: element.updatedAt,
      // Relationships
      artifacts: artifacts,
    );
  }

  factory UserEntity.fromRpc({
    required pbdb.User element,
  }) {
    final artifacts = element.artifacts
        .map((element) => ArtifactEntity.fromRpc(element: element))
        .toList();
    return UserEntity(
      id: element.pk,
      email: element.email,
      dateJoined: element.dateJoined.toDateTime(),
      isDeleted: element.isDeleted,
      deletedAt: element.deletedAt.toDateTime(),
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
      // Relationships
      artifacts: artifacts,
    );
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
  List<ArtifactEntity> artifacts;
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

  factory ArtifactEntity.fromResponse({
    required ArtifactResponse element,
  }) {
    final user = element.user != null
        ? UserEntity.fromResponse(element: element.user!)
        : null;

    return ArtifactEntity(
      id: element.pk,
      userFk: element.userFk,
      title: element.title,
      content: element.content,
      summary: element.summary,
      status: element.status,
      publishFrom: element.publishFrom,
      publishUntil: element.publishUntil,
      createdAt: element.createdAt,
      updatedAt: element.updatedAt,
      // Relationships
      user: user,
    );
  }

  factory ArtifactEntity.fromRpc({
    required pbdb.Artifact element,
  }) {
    final user =
        element.hasUser() ? UserEntity.fromRpc(element: element.user) : null;

    return ArtifactEntity(
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
      user: user,
    );
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
  }) {
    final fromUser = element.hasFromUser()
        ? UserEntity.fromRpc(element: element.fromUser)
        : null;
    final toUser = element.hasToUser()
        ? UserEntity.fromRpc(element: element.toUser)
        : null;

    return MessageEntity(
      id: element.pk,
      fromFk: element.fromFk,
      toFk: element.toFk,
      message: jsonEncode(element.message),
      isRead: element.isRead,
      readAt: element.readAt.toDateTime(),
      isDeleted: element.isDeleted,
      deletedAt: element.deletedAt.toDateTime(),
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
      // Relationships
      fromUser: fromUser,
      toUser: toUser,
    );
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

  Map<String, dynamic>? get messageToJson {
    final decoded = jsonDecode(message);
    if (decoded is! Map<String, dynamic>) {
      return null;
    }

    return decoded;
  }
}

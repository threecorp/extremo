import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:extremo/io/store/api/extremo/extremo_response.dart';
import 'package:extremodart/extremo/msg/db/v1/db.pb.dart' as pbdb;
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat_types;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

part 'extremo.g.dart';

@HiveType(typeId: 0)
class Message {
  Message({required chat_types.Message message})
      : messageJson = jsonEncode(message.toJson());

  @HiveField(0)
  final String messageJson;

  chat_types.Message get message {
    final decodedJson = jsonDecode(messageJson);
    if (decodedJson is Map<String, dynamic>) {
      return chat_types.Message.fromJson(decodedJson);
    }

    // TODO(referctoring): Handle error
    throw const FormatException(
      'Decoded message JSON is not a Map<String, dynamic>',
    );
  }
}

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

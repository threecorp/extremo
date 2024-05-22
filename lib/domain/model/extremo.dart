import 'package:collection/collection.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat_types;
import 'package:extremo/io/entity/extremo/extremo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'extremo.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    int? id,
    required String email,
    DateTime? dateJoined,
    DateTime? deletedAt,
    required bool isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationships
    @Default([]) List<ArtifactModel> artifacts,
  }) = _UserModel;

  factory UserModel.fromEntity({
    required UserEntity entity,
  }) {
    final artifacts = entity.artifacts
        .map((e) => ArtifactModel.fromEntity(entity: e))
        .toList();

    return UserModel(
      id: entity.id,
      email: entity.email,
      dateJoined: entity.dateJoined,
      isDeleted: entity.isDeleted,
      deletedAt: entity.deletedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      // Relationships
      artifacts: artifacts,
    );
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id ?? 0,
      email: email,
      dateJoined: dateJoined,
      isDeleted: isDeleted,
      deletedAt: deletedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      artifacts: artifacts.map((e) => e.toEntity()).toList(),
    );
  }
}

@freezed
class ArtifactModel with _$ArtifactModel {
  const factory ArtifactModel({
    int? id,
    required int userFk,
    required String title,
    required String content,
    required String summary,
    required String status, // XXX: required ArtifactType status,
    DateTime? publishFrom,
    DateTime? publishUntil,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationships
    UserModel? user,
  }) = _ArtifactModel;

  factory ArtifactModel.fromEntity({
    required ArtifactEntity entity,
  }) {
    final user =
        entity.user != null ? UserModel.fromEntity(entity: entity.user!) : null;

    return ArtifactModel(
      id: entity.id,
      userFk: entity.userFk,
      title: entity.title,
      content: entity.content,
      summary: entity.summary,
      status: entity.status,
      publishFrom: entity.publishFrom,
      publishUntil: entity.publishUntil,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      // Relationships
      user: user,
    );
  }
}

extension ArtifactModelX on ArtifactModel {
  ArtifactEntity toEntity() {
    return ArtifactEntity(
      id: id ?? 0,
      userFk: userFk,
      title: title,
      content: content,
      summary: summary,
      status: status,
      publishFrom: publishFrom,
      publishUntil: publishUntil,
      createdAt: createdAt,
      updatedAt: updatedAt,
      user: user?.toEntity(),
    );
  }
}

// enum MessageType {
//   normal(nameJp: "ノーマル", color: 0xffaea886),
//   medium(nameJp: "ミディアム", color: 0xfff45c19),
//   large(nameJp: "ラージ", color: 0xff4a96d6),
//   huge(nameJp: "巨大", color: 0xff28b25c),
//   ;
//
//   final String nameJp;
//
//   final int color;
//   const MessageType({required this.nameJp, required this.color});
//
//   static MessageType? getOrNull(String name) {
//     const List<MessageType?> types = MessageType.values;
//     for (var element in types) {
//       if (element?.name == name) return element;
//     }
//     return null;
//   }
// }

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    int? id,
    required int fromFk,
    required int toFk,
    required chat_types.Message message,
    required bool isRead,
    DateTime? readAt,
    required bool isDeleted,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationships
    UserModel? fromUser,
    UserModel? toUser,
  }) = _MessageModel;

  factory MessageModel.fromEntity({
    required MessageEntity entity,
  }) {
    final fromUser = entity.fromUser != null
        ? UserModel.fromEntity(entity: entity.fromUser!)
        : null;
    final toUser = entity.toUser != null
        ? UserModel.fromEntity(entity: entity.toUser!)
        : null;
    final messageJson = entity.messageToJson;
    final message = messageJson != null
        ? chat_types.Message.fromJson(messageJson)
        : const chat_types.TextMessage(
            id: 'invalid',
            author: chat_types.User(id: 'unknown'),
            text: 'Invalid message',
            type: chat_types.MessageType.unsupported,
          );

    return MessageModel(
      id: entity.id,
      fromFk: entity.fromFk,
      toFk: entity.toFk,
      message: message,
      isRead: entity.isRead,
      readAt: entity.readAt,
      isDeleted: entity.isDeleted,
      deletedAt: entity.deletedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      // Relationships
      fromUser: fromUser,
      toUser: toUser,
    );
  }

  factory MessageModel.fromChatMessage({
    required chat_types.Message chat,
  }) {
    return MessageModel(
      id: 0,
      fromFk: 0,
      toFk: 0,
      message: chat,
      isRead: false,
      // readAt: chat.readAt,
      isDeleted: false,
      // deletedAt: chat.deletedAt,
      // createdAt: chat.createdAt,
      // updatedAt: chat.updatedAt,
      // // Relationships
      // fromUser: null,
      // toUser: null,
    );
  }
}

extension MessageModelX on MessageModel {
  MessageEntity toEntity() {
    return MessageEntity(
      id: id ?? 0,
      fromFk: fromFk,
      toFk: toFk,
      message: message.toJson().toString(),
      isRead: isRead,
      readAt: readAt,
      isDeleted: isDeleted,
      deletedAt: deletedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      fromUser: fromUser?.toEntity(),
      toUser: toUser?.toEntity(),
    );
  }
}

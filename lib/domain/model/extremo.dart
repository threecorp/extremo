import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:extremo/io/entity/extremo/extremo.dart';
import 'package:extremo/misc/logger.dart';
import 'package:extremo/misc/xcontext.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat_types;
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
    UserProfileModel? profile,
    @Default([]) List<ArtifactModel> artifacts,
  }) = _UserModel;

  factory UserModel.fromEntity({
    required UserEntity entity,
    XContext? context,
  }) {
    context ??= XContext.of();

    var model = context.getE<UserModel>(entity.id);
    if (model != null) {
      return model;
    }

    model = UserModel(
      id: entity.id,
      email: entity.email,
      dateJoined: entity.dateJoined,
      isDeleted: entity.isDeleted,
      deletedAt: entity.deletedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      // Relationships
      // profile: profile,
      // artifacts: artifacts,
    );
    context.putE(entity.id, model);

    return model.copyWith(
      profile: entity.profile != null ? UserProfileModel.fromEntity(entity: entity.profile!, context: context) : null,
      artifacts: entity.artifacts.map((e) {
        return context!.getE<ArtifactModel>(e.id) ?? ArtifactModel.fromEntity(entity: e, context: context);
      }).toList(),
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
      profile: profile?.toEntity(),
      artifacts: artifacts.map((e) => e.toEntity()).toList(),
    );
  }
}

@freezed
class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    int? id,
    int? userFk,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationships
    UserModel? user,
  }) = _UserProfileModel;

  factory UserProfileModel.fromEntity({
    required UserProfileEntity entity,
    XContext? context,
  }) {
    context ??= XContext.of();

    var model = context.getE<UserProfileModel>(entity.id);
    if (model != null) {
      return model;
    }

    model = UserProfileModel(
      id: entity.id,
      userFk: entity.userFk,
      name: entity.name,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      // Relationships
      // user: user,
    );
    context.putE(entity.id, model);

    return model.copyWith(
      user: context.getE<UserModel>(entity.userFk) ?? (entity.user != null ? UserModel.fromEntity(entity: entity.user!, context: context) : null),
    );
  }
}

extension UserProfileModelX on UserProfileModel {
  UserProfileEntity toEntity() {
    return UserProfileEntity(
      id: id ?? 0,
      userFk: userFk ?? 0,
      name: name ?? '',
      createdAt: createdAt,
      updatedAt: updatedAt,
      user: user?.toEntity(),
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
    XContext? context,
  }) {
    context ??= XContext.of();

    var model = context.getE<ArtifactModel>(entity.id);
    if (model != null) {
      return model;
    }

    model = ArtifactModel(
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
      // user: user
    );
    context.putE(entity.id, model);

    return model.copyWith(
      user: context.getE<UserModel>(entity.userFk) ?? (entity.user != null ? UserModel.fromEntity(entity: entity.user!, context: context) : null),
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
class ChatModel with _$ChatModel {
  const factory ChatModel({
    int? id,
    required int tenantFk,
    required int senderFk,
    required int recipientFk,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationships
    UserModel? senderUser,
    UserModel? recipientUser,
  }) = _ChatModel;

  factory ChatModel.fromEntity({
    required ChatEntity entity,
    XContext? context,
  }) {
    context ??= XContext.of();

    var model = context.getE<ChatModel>(entity.id);
    if (model != null) {
      return model;
    }

    model = ChatModel(
      id: entity.id,
      tenantFk: entity.tenantFk,
      senderFk: entity.senderFk,
      recipientFk: entity.recipientFk,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      // Relationships
      // senderUser: senderUser,
      // recipientUser: recipientUser,
    );
    context.putE(entity.id, model);

    return model.copyWith(
      senderUser: context.getE<UserModel>(entity.senderFk) ?? (entity.senderUser != null ? UserModel.fromEntity(entity: entity.senderUser!, context: context) : null),
      recipientUser: context.getE<UserModel>(entity.recipientFk) ?? (entity.recipientUser != null ? UserModel.fromEntity(entity: entity.recipientUser!, context: context) : null),
    );
  }
}

extension ChatModelX on ChatModel {
  ChatEntity toEntity() {
    return ChatEntity(
      id: id ?? 0,
      tenantFk: tenantFk,
      senderFk: senderFk,
      recipientFk: recipientFk,
      createdAt: createdAt,
      updatedAt: updatedAt,
      senderUser: senderUser?.toEntity(),
      recipientUser: recipientUser?.toEntity(),
    );
  }
}

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    int? id,
    required int fromFk,
    required int toFk,
    required String message,
    required bool isRead,
    DateTime? readAt,
    required bool isDeleted,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationships
    UserModel? fromUser,
    UserModel? toUser,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromEntity({
    required ChatMessageEntity entity,
    XContext? context,
  }) {
    context ??= XContext.of();

    var model = context.getE<ChatMessageModel>(entity.id);
    if (model != null) {
      return model;
    }

    model = ChatMessageModel(
      id: entity.id,
      fromFk: entity.fromFk,
      toFk: entity.toFk,
      message: entity.message,
      isRead: entity.isRead,
      readAt: entity.readAt,
      isDeleted: entity.isDeleted,
      deletedAt: entity.deletedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      // Relationships
      // fromUser: fromUser,
      // toUser: toUser,
    );
    context.putE(entity.id, model);

    return model.copyWith(
      fromUser: context.getE<UserModel>(entity.fromFk) ?? (entity.fromUser != null ? UserModel.fromEntity(entity: entity.fromUser!, context: context) : null),
      toUser: context.getE<UserModel>(entity.toFk) ?? (entity.toUser != null ? UserModel.fromEntity(entity: entity.toUser!, context: context) : null),
    );
  }

  factory ChatMessageModel.fromChatMessage({
    required chat_types.Message chat,
  }) {
    return ChatMessageModel(
      id: 0,
      fromFk: 0,
      toFk: 0,
      message: chat.toJson().toString(),
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

extension ChatMessageModelX on ChatMessageModel {
  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      id: id ?? 0,
      fromFk: fromFk,
      toFk: toFk,
      message: message,
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

  chat_types.Message? get toChatMessage {
    final decoded = toChatJson;
    if (decoded is! Map<String, dynamic>) {
      return null;
    }

    return chat_types.Message.fromJson(decoded);
  }

  Map<String, dynamic>? get toChatJson {
    final decoded = jsonDecode(message);
    if (decoded is! Map<String, dynamic>) {
      return null;
    }

    return decoded;
  }
}

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
class TenantEntity {
  TenantEntity({
    required this.pk,
    this.createdAt,
    this.updatedAt,
    // Reverse Relationships
    this.profile,
    this.users = const [],
    this.chats = const [],
    this.services = const [],
    // this.teams = const [],
    // this.books = const [],
  });

  factory TenantEntity.fromRpc({
    required pbdb.Tenant element,
    XContext? context,
  }) {
    context ??= XContext.of();

    var entity = context.getE<TenantEntity>(element.pk);
    if (entity != null) {
      return entity;
    }

    entity = TenantEntity(
      pk: element.pk,
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
    );
    context.putE(entity.pk, entity);

    // Reverse Relationships
    entity
      ..profile = element.hasProfile() ? TenantProfileEntity.fromRpc(element: element.profile, context: context) : null
      ..users = element.users.map((e) => context!.getE<UserEntity>(e.pk) ?? UserEntity.fromRpc(element: e, context: context)).toList()
      ..chats = element.chats.map((e) => context!.getE<ChatEntity>(e.pk) ?? ChatEntity.fromRpc(element: e, context: context)).toList()
      ..services = element.services.map((e) => context!.getE<ServiceEntity>(e.pk) ?? ServiceEntity.fromRpc(element: e, context: context)).toList();
    return entity;
  }

  @HiveField(0)
  int pk;

  @HiveField(6)
  DateTime? createdAt;

  @HiveField(7)
  DateTime? updatedAt;

  // Reverse Relationships
  TenantProfileEntity? profile;
  List<UserEntity> users;
  List<ChatEntity> chats;
  List<ServiceEntity> services;
  // List<TeamEntity> teams;
  // List<BookEntity> books;
}

@HiveType(typeId: 2)
class TenantProfileEntity {
  TenantProfileEntity({
    required this.pk,
    required this.tenantFk,
    this.name = '',
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.tenant,
  });

  factory TenantProfileEntity.fromRpc({
    required pbdb.TenantProfile element,
    XContext? context,
  }) {
    context ??= XContext.of();

    var entity = context.getE<TenantProfileEntity>(element.pk);
    if (entity != null) {
      return entity;
    }

    entity = TenantProfileEntity(
      pk: element.pk,
      tenantFk: element.tenantFk,
      name: element.name,
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
    );
    context.putE(entity.pk, entity);

    // Relationships
    entity.tenant = context.getE<TenantEntity>(element.tenantFk) ?? (element.hasTenant() ? TenantEntity.fromRpc(element: element.tenant, context: context) : null);

    return entity;
  }

  @HiveField(0)
  int pk;

  @HiveField(1)
  int tenantFk;

  @HiveField(2)
  String name;

  @HiveField(3)
  DateTime? createdAt;

  @HiveField(4)
  DateTime? updatedAt;

  // Relationships
  TenantEntity? tenant; // TODO(impl): OneToOne must be required
}

@HiveType(typeId: 3)
class UserEntity {
  UserEntity({
    required this.pk,
    required this.tenantFk,
    this.email = '',
    this.dateJoined,
    this.deletedAt,
    required this.isDeleted,
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.profile,
    this.tenant,
    this.artifacts = const [],
  });

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
      pk: element.pk,
      tenantFk: element.tenantFk,
      email: element.email,
      dateJoined: element.dateJoined.toDateTime(),
      isDeleted: element.isDeleted,
      deletedAt: element.deletedAt.toDateTime(),
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
    );
    context.putE(entity.pk, entity);

    // Relationships
    entity
      // foreign keys
      ..artifacts = element.artifacts.map((e) => context!.getE<ArtifactEntity>(e.pk) ?? ArtifactEntity.fromRpc(element: e, context: context)).toList()
      ..tenant = context.getE<TenantEntity>(element.tenantFk) ?? (element.hasTenant() ? TenantEntity.fromRpc(element: element.tenant, context: context) : null)
      // Reverses
      ..profile = element.hasProfile() ? UserProfileEntity.fromRpc(element: element.profile, context: context) : null;
    return entity;
  }

  @HiveField(0)
  int pk;

  @HiveField(1)
  int tenantFk;

  @HiveField(2)
  String email;

  @HiveField(3)
  DateTime? dateJoined;

  @HiveField(4)
  bool isDeleted;

  @HiveField(5)
  DateTime? deletedAt;

  @HiveField(6)
  DateTime? createdAt;

  @HiveField(7)
  DateTime? updatedAt;

  // Relationships
  TenantEntity? tenant; // TODO(impl): OneToOne must be required
  List<ArtifactEntity> artifacts;
  // Reverse Relationships
  UserProfileEntity? profile;
}

@HiveType(typeId: 4)
class UserProfileEntity {
  UserProfileEntity({
    required this.pk,
    required this.userFk,
    this.name = '',
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.user,
  });

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
      pk: element.pk,
      userFk: element.userFk,
      name: element.name,
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
    );
    context.putE(entity.pk, entity);

    // Relationships
    entity.user = (context.getE<UserEntity>(element.userFk)) ?? (element.hasUser() ? UserEntity.fromRpc(element: element.user, context: context) : null);

    return entity;
  }

  @HiveField(0)
  int pk;

  @HiveField(1)
  int userFk;

  @HiveField(2)
  String name;

  @HiveField(3)
  DateTime? createdAt;

  @HiveField(4)
  DateTime? updatedAt;

  // Relationships
  UserEntity? user; // TODO(impl): OneToOne must be required
}

@HiveType(typeId: 5)
class ArtifactEntity {
  ArtifactEntity({
    required this.pk,
    required this.userFk,
    this.title = '',
    this.content = '',
    this.summary = '',
    this.status = '', // TODO(impl): Enum Type
    this.publishFrom,
    this.publishUntil,
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.user,
  });

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
      pk: element.pk,
      userFk: element.userFk,
      title: element.title,
      content: element.content,
      summary: element.summary,
      status: element.status.name,
      publishFrom: element.publishFrom.toDateTime(),
      publishUntil: element.publishUntil.toDateTime(),
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
    );
    context.putE(entity.pk, entity);

    // Relationships
    entity.user = (context.getE<UserEntity>(element.userFk)) ?? (element.hasUser() ? UserEntity.fromRpc(element: element.user, context: context) : null);

    return entity;
  }

  @HiveField(0)
  int pk;

  @HiveField(1)
  int userFk;

  @HiveField(2)
  String title;

  @HiveField(3)
  String content;

  @HiveField(4)
  String summary;

  @HiveField(5)
  String status; // TODO(impl): Enum Type

  @HiveField(6)
  DateTime? publishFrom;

  @HiveField(7)
  DateTime? publishUntil;

  @HiveField(8)
  DateTime? createdAt;

  @HiveField(9)
  DateTime? updatedAt;

  // Relationships
  UserEntity? user; // TODO(impl): OneToOne must be required
}

@HiveType(typeId: 6)
class ChatEntity {
  ChatEntity({
    required this.pk,
    required this.tenantFk,
    required this.senderFk,
    required this.recipientFk,
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.senderUser,
    this.recipientUser,
  });

  factory ChatEntity.fromRpc({
    required pbdb.Chat element,
    XContext? context,
  }) {
    context ??= XContext.of();

    var entity = context.getE<ChatEntity>(element.pk);
    if (entity != null) {
      return entity;
    }
    entity = ChatEntity(
      pk: element.pk,
      tenantFk: element.tenantFk,
      senderFk: element.senderFk,
      recipientFk: element.recipientFk,
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
    );
    context.putE(entity.pk, entity);

    // Relationships
    entity
      ..senderUser = context.getE<UserEntity>(element.senderFk) ?? (element.hasSender() ? UserEntity.fromRpc(element: element.sender, context: context) : null)
      ..recipientUser = context.getE<UserEntity>(element.recipientFk) ?? (element.hasRecipient() ? UserEntity.fromRpc(element: element.recipient, context: context) : null)
      ..tenant = context.getE<TenantEntity>(element.tenantFk) ?? (element.hasTenant() ? TenantEntity.fromRpc(element: element.tenant, context: context) : null);

    return entity;
  }

  @HiveField(0)
  int pk;

  @HiveField(1)
  int tenantFk;

  @HiveField(2)
  int senderFk;

  @HiveField(3)
  int recipientFk;

  @HiveField(10)
  DateTime? createdAt;

  @HiveField(11)
  DateTime? updatedAt;

  // Relationships
  UserEntity? senderUser; // TODO(impl): OneToOne must be required
  UserEntity? recipientUser; // TODO(impl): OneToOne must be required
  TenantEntity? tenant; // TODO(impl): OneToOne must be required
}

@HiveType(typeId: 7)
class ChatMessageEntity {
  ChatMessageEntity({
    required this.pk,
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

  factory ChatMessageEntity.fromRpc({
    required pbdb.ChatMessage element,
    XContext? context,
  }) {
    context ??= XContext.of();

    var entity = context.getE<ChatMessageEntity>(element.pk);
    if (entity != null) {
      return entity;
    }
    entity = ChatMessageEntity(
      pk: element.pk,
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
    context.putE(entity.pk, entity);

    entity
      ..fromUser = (context.getE<UserEntity>(element.fromFk)) ?? (element.hasFromUser() ? UserEntity.fromRpc(element: element.fromUser, context: context) : null)
      ..toUser = (context.getE<UserEntity>(element.toFk)) ?? (element.hasToUser() ? UserEntity.fromRpc(element: element.toUser, context: context) : null);

    return entity;
  }

  @HiveField(0)
  int pk;

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

@HiveType(typeId: 8)
class ServiceEntity {
  ServiceEntity({
    required this.pk,
    required this.tenantFk,
    this.parentFk,
    required this.name,
    this.desc = '',
    required this.price,
    this.sort = 0,
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.tenant,
    this.parent,
  });

  factory ServiceEntity.fromRpc({
    required pbdb.Service element,
    XContext? context,
  }) {
    context ??= XContext.of();

    var entity = context.getE<ServiceEntity>(element.pk);
    if (entity != null) {
      return entity;
    }
    entity = ServiceEntity(
      pk: element.pk,
      tenantFk: element.tenantFk,
      parentFk: element.parentFk,
      name: element.name,
      desc: element.desc,
      price: element.price,
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
    );
    context.putE(entity.pk, entity);

    // Relationships
    entity
      ..parent = (context.getE<ServiceEntity>(element.parentFk)) ?? (element.hasParent() ? ServiceEntity.fromRpc(element: element.parent, context: context) : null)
      ..tenant = (context.getE<TenantEntity>(element.tenantFk)) ?? (element.hasTenant() ? TenantEntity.fromRpc(element: element.tenant, context: context) : null);

    return entity;
  }

  @HiveField(0)
  int pk;

  @HiveField(1)
  int tenantFk;

  @HiveField(2)
  int? parentFk;

  @HiveField(3)
  String name;

  @HiveField(4)
  String desc;

  @HiveField(5)
  int? price;

  @HiveField(6)
  int sort;

  @HiveField(10)
  DateTime? createdAt;

  @HiveField(11)
  DateTime? updatedAt;

  // Relationships
  TenantEntity? tenant; // TODO(impl): OneToOne is required
  // Nullable relationships
  ServiceEntity? parent;
}

import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:extremo/io/store/api/extremo/extremo_response.dart';
import 'package:extremo/misc/logger.dart';
import 'package:extremo/misc/xcontext.dart';
import 'package:extremodart/extremo/msg/db/v1/db.pb.dart';
import 'package:extremodart/extremo/msg/db/v1/enum.pbenum.dart';
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
    this.teams = const [],
    this.books = const [],
  });

  factory TenantEntity.fromRpc({
    required Tenant element,
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
      ..books = element.books.map((e) => context!.getE<BookEntity>(e.pk) ?? BookEntity.fromRpc(element: e, context: context)).toList()
      ..chats = element.chats.map((e) => context!.getE<ChatEntity>(e.pk) ?? ChatEntity.fromRpc(element: e, context: context)).toList()
      ..services = element.services.map((e) => context!.getE<ServiceEntity>(e.pk) ?? ServiceEntity.fromRpc(element: e, context: context)).toList()
      ..users = element.users.map((e) => context!.getE<UserEntity>(e.pk) ?? UserEntity.fromRpc(element: e, context: context)).toList()
      ..teams = element.teams.map((e) => context!.getE<TeamEntity>(e.pk) ?? TeamEntity.fromRpc(element: e, context: context)).toList();
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
  List<BookEntity> books;
  List<ChatEntity> chats;
  List<ServiceEntity> services;
  List<TeamEntity> teams;
  List<UserEntity> users;
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
    required TenantProfile element,
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
    required User element,
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
    required UserProfile element,
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
    required Artifact element,
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
    required this.clientFk,
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.clientUser,
  });

  factory ChatEntity.fromRpc({
    required Chat element,
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
      clientFk: element.clientFk,
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
    );
    context.putE(entity.pk, entity);

    // Relationships
    entity
      ..clientUser = context.getE<UserEntity>(element.clientFk) ?? (element.hasClient() ? UserEntity.fromRpc(element: element.client, context: context) : null)
      ..tenant = context.getE<TenantEntity>(element.tenantFk) ?? (element.hasTenant() ? TenantEntity.fromRpc(element: element.tenant, context: context) : null);

    return entity;
  }

  @HiveField(0)
  int pk;

  @HiveField(1)
  int tenantFk;

  // 2

  @HiveField(3)
  int clientFk;

  @HiveField(10)
  DateTime? createdAt;

  @HiveField(11)
  DateTime? updatedAt;

  // Relationships
  UserEntity? clientUser; // TODO(impl): OneToOne must be required
  TenantEntity? tenant; // TODO(impl): OneToOne must be required
}

@HiveType(typeId: 7)
class ChatMessageEntity {
  ChatMessageEntity({
    required this.pk,
    required this.chatFk,
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
    this.chat,
    this.fromUser,
    this.toUser,
  });

  factory ChatMessageEntity.fromRpc({
    required ChatMessage element,
    XContext? context,
  }) {
    context ??= XContext.of();

    var entity = context.getE<ChatMessageEntity>(element.pk);
    if (entity != null) {
      return entity;
    }
    entity = ChatMessageEntity(
      pk: element.pk,
      chatFk: element.chatFk,
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
      ..chat = (context.getE<ChatEntity>(element.chatFk)) ?? (element.hasChat() ? ChatEntity.fromRpc(element: element.chat, context: context) : null)
      ..fromUser = (context.getE<UserEntity>(element.fromFk)) ?? (element.hasFromUser() ? UserEntity.fromRpc(element: element.fromUser, context: context) : null)
      ..toUser = (context.getE<UserEntity>(element.toFk)) ?? (element.hasToUser() ? UserEntity.fromRpc(element: element.toUser, context: context) : null);

    return entity;
  }

  @HiveField(0)
  int pk;

  @HiveField(1)
  int chatFk;

  @HiveField(2)
  int fromFk;

  @HiveField(3)
  int toFk;

  @HiveField(4)
  String message;

  @HiveField(5)
  bool isRead;

  @HiveField(6)
  DateTime? readAt;

  @HiveField(7)
  bool isDeleted;

  @HiveField(8)
  DateTime? deletedAt;

  @HiveField(9)
  DateTime? createdAt;

  @HiveField(10)
  DateTime? updatedAt;

  // Relationships
  ChatEntity? chat;
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
    this.price,
    this.sort = 0,
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.tenant,
    this.parent,
  });

  factory ServiceEntity.fromRpc({
    required Service element,
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

class BookEnumStatusAdapter extends TypeAdapter<BookEnum_Status> {
  @override
  final int typeId = 200;

  @override
  BookEnum_Status read(BinaryReader reader) {
    final value = reader.readInt();
    return BookEnum_Status.valueOf(value) ?? BookEnum_Status.STATUS_UNSPECIFIED;
  }

  @override
  void write(BinaryWriter writer, BookEnum_Status obj) {
    writer.writeInt(obj.value);
  }
}

@HiveType(typeId: 9)
class BookEntity {
  BookEntity({
    required this.pk,
    required this.tenantFk,
    required this.name,
    this.desc = '',
    this.status = BookEnum_Status.DRAFT,
    required this.openedAt,
    required this.closedAt,
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.tenant,
    this.clients = const [],
    this.teams = const [],
    this.booksServices = const [],
  });

  factory BookEntity.fromRpc({
    required Book element,
    XContext? context,
  }) {
    context ??= XContext.of();

    var entity = context.getE<BookEntity>(element.pk);
    if (entity != null) {
      return entity;
    }
    entity = BookEntity(
      pk: element.pk,
      tenantFk: element.tenantFk,
      name: element.name,
      desc: element.desc,
      status: element.status,
      openedAt: element.openedAt.toDateTime(),
      closedAt: element.closedAt.toDateTime(),
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
    );
    context.putE(entity.pk, entity);

    // Relationships
    entity
      ..tenant = (context.getE<TenantEntity>(element.tenantFk)) ?? (element.hasTenant() ? TenantEntity.fromRpc(element: element.tenant, context: context) : null)
      ..clients = element.clients.map((e) => context!.getE<UserEntity>(e.pk) ?? UserEntity.fromRpc(element: e, context: context)).toList()
      ..teams = element.teams.map((e) => context!.getE<TeamEntity>(e.pk) ?? TeamEntity.fromRpc(element: e, context: context)).toList()
      ..booksServices = element.booksServices.map((e) => context!.getE<BooksServiceEntity>(e.pk) ?? BooksServiceEntity.fromRpc(element: e, context: context)).toList();

    return entity;
  }

  @HiveField(0)
  int pk;

  @HiveField(1)
  int tenantFk;

  @HiveField(2)
  String name;

  @HiveField(3)
  String desc;

  @HiveField(4)
  BookEnum_Status status;

  @HiveField(5)
  DateTime openedAt;

  @HiveField(6)
  DateTime closedAt;

  @HiveField(10)
  DateTime? createdAt;

  @HiveField(11)
  DateTime? updatedAt;

  // Relationships
  TenantEntity? tenant; // TODO(impl): OneToOne is required
  List<UserEntity> clients;
  List<TeamEntity> teams;
  List<BooksServiceEntity> booksServices;
}

@HiveType(typeId: 10)
class TeamEntity {
  TeamEntity({
    required this.pk,
    required this.tenantFk,
    required this.name,
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.tenant,
    this.users = const [],
  });

  factory TeamEntity.fromRpc({
    required Team element,
    XContext? context,
  }) {
    context ??= XContext.of();

    var entity = context.getE<TeamEntity>(element.pk);
    if (entity != null) {
      return entity;
    }
    entity = TeamEntity(
      pk: element.pk,
      tenantFk: element.tenantFk,
      name: element.name,
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
    );
    context.putE(entity.pk, entity);

    // Relationships
    entity.tenant = (context.getE<TenantEntity>(element.tenantFk)) ?? (element.hasTenant() ? TenantEntity.fromRpc(element: element.tenant, context: context) : null);
    // TODO(impl): ..users = element.users.map((e) => context!.getE<UserEntity>(e.pk) ?? UserEntity.fromRpc(element: e, context: context)).toList();

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
  TenantEntity? tenant; // TODO(impl): OneToOne is required
  List<UserEntity> users;
}

@HiveType(typeId: 11)
class BooksServiceEntity {
  BooksServiceEntity({
    required this.pk,
    required this.bookFk,
    this.serviceFk,
    this.name = '',
    this.desc = '',
    this.price,
    this.createdAt,
    this.updatedAt,
    // Relationships
    this.book,
    this.service,
  });

  factory BooksServiceEntity.fromRpc({
    required BooksService element,
    XContext? context,
  }) {
    context ??= XContext.of();

    var entity = context.getE<BooksServiceEntity>(element.pk);
    if (entity != null) {
      return entity;
    }
    entity = BooksServiceEntity(
      pk: element.pk,
      bookFk: element.bookFk,
      serviceFk: element.serviceFk,
      name: element.name,
      desc: element.desc,
      price: element.price,
      createdAt: element.createdAt.toDateTime(),
      updatedAt: element.updatedAt.toDateTime(),
    );
    context.putE(entity.pk, entity);

    // Relationships
    entity
      ..book = (context.getE<BookEntity>(element.bookFk)) ?? (element.hasBook() ? BookEntity.fromRpc(element: element.book, context: context) : null)
      ..service = (context.getE<ServiceEntity>(element.serviceFk)) ?? (element.hasService() ? ServiceEntity.fromRpc(element: element.service, context: context) : null);

    return entity;
  }

  @HiveField(0)
  int pk;

  @HiveField(1)
  int bookFk;

  @HiveField(2)
  int? serviceFk;

  @HiveField(3)
  String name;

  @HiveField(4)
  String desc;

  @HiveField(5)
  int? price;

  @HiveField(10)
  DateTime? createdAt;

  @HiveField(11)
  DateTime? updatedAt;

  // Relationships
  BookEntity? book; // TODO(impl): OneToOne is required
  ServiceEntity? service; // TODO(impl): OneToOne is required
}

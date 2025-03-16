import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:extremo/io/entity/extremo/extremo.dart';
import 'package:extremo/misc/logger.dart';
import 'package:extremo/misc/xcontext.dart';
import 'package:extremodart/extremo/msg/db/v1/enum.pbenum.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat_types;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'extremo.freezed.dart';

@freezed
class TenantModel with _$TenantModel {
  const factory TenantModel({
    int? pk,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationships
    TenantProfileModel? profile,
    @Default([]) List<UserModel> users,
    @Default([]) List<ChatModel> chats,
    @Default([]) List<ServiceModel> services,
    @Default([]) List<TeamModel> teams,
    @Default([]) List<BookModel> books,
  }) = _TenantModel;

  factory TenantModel.fromEntity({
    required TenantEntity entity,
    XContext? context,
  }) {
    context ??= XContext.of();

    var model = context.getE<TenantModel>(entity.pk);
    if (model != null) {
      return model;
    }
    model = TenantModel(
      pk: entity.pk,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
    context.putE(entity.pk, model);

    // Relationships
    return model.copyWith(
      profile: entity.profile != null ? TenantProfileModel.fromEntity(entity: entity.profile!, context: context) : null,
      users: entity.users.map((e) => context!.getE<UserModel>(e.pk) ?? UserModel.fromEntity(entity: e, context: context)).toList(),
      chats: entity.chats.map((e) => context!.getE<ChatModel>(e.pk) ?? ChatModel.fromEntity(entity: e, context: context)).toList(),
      services: entity.services.map((e) => context!.getE<ServiceModel>(e.pk) ?? ServiceModel.fromEntity(entity: e, context: context)).toList(),
      books: entity.books.map((e) => context!.getE<BookModel>(e.pk) ?? BookModel.fromEntity(entity: e, context: context)).toList(),
      teams: entity.teams.map((e) => context!.getE<TeamModel>(e.pk) ?? TeamModel.fromEntity(entity: e, context: context)).toList(),
    );
  }
}

extension TenantModelX on TenantModel {
  TenantEntity toEntity() {
    return TenantEntity(
      pk: pk ?? 0,
      createdAt: createdAt,
      updatedAt: updatedAt,
      profile: profile?.toEntity(),
      teams: teams.map((e) => e.toEntity()).toList(),
      books: books.map((e) => e.toEntity()).toList(),
      chats: chats.map((e) => e.toEntity()).toList(),
      services: services.map((e) => e.toEntity()).toList(),
      users: users.map((e) => e.toEntity()).toList(),
    );
  }
}

@freezed
class TenantProfileModel with _$TenantProfileModel {
  const factory TenantProfileModel({
    int? pk,
    int? tenantFk,
    @Default('') String name,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationships
    TenantModel? tenant,
  }) = _TenantProfileModel;

  factory TenantProfileModel.fromEntity({
    required TenantProfileEntity entity,
    XContext? context,
  }) {
    context ??= XContext.of();

    var model = context.getE<TenantProfileModel>(entity.pk);
    if (model != null) {
      return model;
    }

    model = TenantProfileModel(
      pk: entity.pk,
      tenantFk: entity.tenantFk,
      name: entity.name,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
    context.putE(entity.pk, model);

    // Relationships
    return model.copyWith(
      tenant: context.getE<TenantModel>(entity.tenantFk) ?? (entity.tenant != null ? TenantModel.fromEntity(entity: entity.tenant!, context: context) : null),
    );
  }
}

extension TenantProfileModelX on TenantProfileModel {
  TenantProfileEntity toEntity() {
    return TenantProfileEntity(
      pk: pk ?? 0,
      tenantFk: tenantFk ?? 0,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
      tenant: tenant?.toEntity(),
    );
  }
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    int? pk,
    int? tenantFk,
    @Default('') String email,
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

    var model = context.getE<UserModel>(entity.pk);
    if (model != null) {
      return model;
    }

    model = UserModel(
      pk: entity.pk,
      tenantFk: entity.tenantFk,
      email: entity.email,
      dateJoined: entity.dateJoined,
      isDeleted: entity.isDeleted,
      deletedAt: entity.deletedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
    context.putE(entity.pk, model);

    // Relationships
    return model.copyWith(
      profile: entity.profile != null ? UserProfileModel.fromEntity(entity: entity.profile!, context: context) : null,
      artifacts: entity.artifacts.map((e) => context!.getE<ArtifactModel>(e.pk) ?? ArtifactModel.fromEntity(entity: e, context: context)).toList(),
    );
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      pk: pk ?? 0,
      tenantFk: tenantFk ?? 0,
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
    int? pk,
    int? userFk,
    @Default('') String name,
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

    var model = context.getE<UserProfileModel>(entity.pk);
    if (model != null) {
      return model;
    }

    model = UserProfileModel(
      pk: entity.pk,
      userFk: entity.userFk,
      name: entity.name,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
    context.putE(entity.pk, model);

    // Relationships
    return model.copyWith(
      user: context.getE<UserModel>(entity.userFk) ?? (entity.user != null ? UserModel.fromEntity(entity: entity.user!, context: context) : null),
    );
  }
}

extension UserProfileModelX on UserProfileModel {
  UserProfileEntity toEntity() {
    return UserProfileEntity(
      pk: pk ?? 0,
      userFk: userFk ?? 0,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
      user: user?.toEntity(),
    );
  }
}

@freezed
class ArtifactModel with _$ArtifactModel {
  const factory ArtifactModel({
    int? pk,
    required int userFk,
    @Default('') String title,
    @Default('') String content,
    @Default('') String summary,
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

    var model = context.getE<ArtifactModel>(entity.pk);
    if (model != null) {
      return model;
    }

    model = ArtifactModel(
      pk: entity.pk,
      userFk: entity.userFk,
      title: entity.title,
      content: entity.content,
      summary: entity.summary,
      status: entity.status,
      publishFrom: entity.publishFrom,
      publishUntil: entity.publishUntil,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
    context.putE(entity.pk, model);

    // Relationships
    return model.copyWith(
      user: context.getE<UserModel>(entity.userFk) ?? (entity.user != null ? UserModel.fromEntity(entity: entity.user!, context: context) : null),
    );
  }
}

extension ArtifactModelX on ArtifactModel {
  ArtifactEntity toEntity() {
    return ArtifactEntity(
      pk: pk ?? 0,
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

@freezed
class ServiceModel with _$ServiceModel {
  const factory ServiceModel({
    int? pk,
    int? tenantFk,
    int? parentFk,
    @Default('') String name,
    @Default('') String desc,
    int? price,
    @Default(0) int sort,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationships
    TenantModel? tenant,
    ServiceModel? parent,
  }) = _ServiceModel;

  factory ServiceModel.fromEntity({
    required ServiceEntity entity,
    XContext? context,
  }) {
    context ??= XContext.of();

    var model = context.getE<ServiceModel>(entity.pk);
    if (model != null) {
      return model;
    }
    model = ServiceModel(
      pk: entity.pk,
      tenantFk: entity.tenantFk,
      parentFk: entity.parentFk,
      name: entity.name,
      desc: entity.desc,
      price: entity.price,
      sort: entity.sort,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
    context.putE(entity.pk, model);

    // Relationships

    return model.copyWith(
      tenant: context.getE<TenantModel>(entity.tenantFk) ?? (entity.tenant != null ? TenantModel.fromEntity(entity: entity.tenant!, context: context) : null),
      parent: (() {
        if (entity.parentFk == null) {
          return null;
        }

        return context!.getE<ServiceModel>(entity.parentFk!) ?? (entity.parent != null ? ServiceModel.fromEntity(entity: entity.parent!, context: context) : null);
      })(),
    );
  }
}

extension ServiceModelX on ServiceModel {
  ServiceEntity toEntity() {
    return ServiceEntity(
      pk: pk ?? 0,
      tenantFk: tenantFk ?? 0,
      parentFk: parentFk,
      name: name,
      desc: desc,
      price: price,
      sort: sort,
      createdAt: createdAt,
      updatedAt: updatedAt,
      tenant: tenant?.toEntity(),
      parent: parent?.toEntity(),
    );
  }
}

@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel({
    int? pk,
    int? tenantFk,
    required int recipientFk,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationships
    UserModel? recipientUser,
  }) = _ChatModel;

  factory ChatModel.fromEntity({
    required ChatEntity entity,
    XContext? context,
  }) {
    context ??= XContext.of();

    var model = context.getE<ChatModel>(entity.pk);
    if (model != null) {
      return model;
    }

    model = ChatModel(
      pk: entity.pk,
      tenantFk: entity.tenantFk,
      recipientFk: entity.recipientFk,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
    context.putE(entity.pk, model);

    // Relationships
    return model.copyWith(
      recipientUser: context.getE<UserModel>(entity.recipientFk) ?? (entity.recipientUser != null ? UserModel.fromEntity(entity: entity.recipientUser!, context: context) : null),
    );
  }
}

extension ChatModelX on ChatModel {
  ChatEntity toEntity() {
    return ChatEntity(
      pk: pk ?? 0,
      tenantFk: tenantFk ?? 0,
      recipientFk: recipientFk,
      createdAt: createdAt,
      updatedAt: updatedAt,
      recipientUser: recipientUser?.toEntity(),
    );
  }
}

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    int? pk,
    required int fromFk,
    required int toFk,
    @Default('') String message,
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

    var model = context.getE<ChatMessageModel>(entity.pk);
    if (model != null) {
      return model;
    }

    model = ChatMessageModel(
      pk: entity.pk,
      fromFk: entity.fromFk,
      toFk: entity.toFk,
      message: entity.message,
      isRead: entity.isRead,
      readAt: entity.readAt,
      isDeleted: entity.isDeleted,
      deletedAt: entity.deletedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
    context.putE(entity.pk, model);

    // Relationships
    return model.copyWith(
      fromUser: context.getE<UserModel>(entity.fromFk) ?? (entity.fromUser != null ? UserModel.fromEntity(entity: entity.fromUser!, context: context) : null),
      toUser: context.getE<UserModel>(entity.toFk) ?? (entity.toUser != null ? UserModel.fromEntity(entity: entity.toUser!, context: context) : null),
    );
  }

  factory ChatMessageModel.fromChatMessage({
    required chat_types.Message chat,
  }) {
    return ChatMessageModel(
      pk: 0,
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
      pk: pk ?? 0,
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

@freezed
class BookModel with _$BookModel {
  const factory BookModel({
    int? pk,
    int? tenantFk,
    @Default('') String name,
    @Default('') String desc,
    @Default(BookEnum_Status.DRAFT) BookEnum_Status status,
    required DateTime openedAt,
    required DateTime closedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationships
    TenantModel? tenant,
    @Default([]) List<UserModel> clients,
    @Default([]) List<TeamModel> teams,
    @Default([]) List<BooksServiceModel> booksServices,
  }) = _BookModel;

  factory BookModel.fromEntity({
    required BookEntity entity,
    XContext? context,
  }) {
    context ??= XContext.of();

    var model = context.getE<BookModel>(entity.pk);
    if (model != null) {
      return model;
    }
    model = BookModel(
      pk: entity.pk,
      tenantFk: entity.tenantFk,
      name: entity.name,
      desc: entity.desc,
      status: entity.status,
      openedAt: entity.openedAt,
      closedAt: entity.closedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
    context.putE(entity.pk, model);

    // Relationships
    return model.copyWith(
      tenant: context.getE<TenantModel>(entity.tenantFk) ?? (entity.tenant != null ? TenantModel.fromEntity(entity: entity.tenant!, context: context) : null),
      clients: entity.clients.map((e) => context!.getE<UserModel>(e.pk) ?? UserModel.fromEntity(entity: e, context: context)).toList(),
      teams: entity.teams.map((e) => context!.getE<TeamModel>(e.pk) ?? TeamModel.fromEntity(entity: e, context: context)).toList(),
      booksServices: entity.booksServices.map((e) => context!.getE<BooksServiceModel>(e.pk) ?? BooksServiceModel.fromEntity(entity: e, context: context)).toList(),
    );
  }

  // factory BookModel.fromReserve({
  //   String? pk,
  //   UserModel? user,
  //   ServiceModel? service,
  //   required String name,
  //   required DateTime openedAt,
  //   required DateTime closedAt,
  //   // required Color background,
  //   // required bool isAllDay,
  // }) {
  //   return BookModel(
  //     pk: pk,
  //     user: user,
  //     service: service,
  //     name: name,
  //     openedAt: openedAt,
  //     closedAt: closedAt,
  //     // background: background,
  //     // isAllDay: isAllDay,
  //   );
  // }
}

extension BookModelX on BookModel {
  BookEntity toEntity() {
    return BookEntity(
      pk: pk ?? 0,
      tenantFk: tenantFk ?? 0,
      name: name,
      desc: desc,
      status: status,
      openedAt: openedAt,
      closedAt: closedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      tenant: tenant?.toEntity(),
      clients: clients.map((e) => e.toEntity()).toList(),
      teams: teams.map((e) => e.toEntity()).toList(),
      booksServices: booksServices.map((e) => e.toEntity()).toList(),
    );
  }
}

@freezed
class TeamModel with _$TeamModel {
  const factory TeamModel({
    int? pk,
    int? tenantFk,
    @Default('') String name,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationships
    TenantModel? tenant,
    @Default([]) List<UserModel> users,
  }) = _TeamModel;

  factory TeamModel.fromEntity({
    required TeamEntity entity,
    XContext? context,
  }) {
    context ??= XContext.of();

    var model = context.getE<TeamModel>(entity.pk);
    if (model != null) {
      return model;
    }
    model = TeamModel(
      pk: entity.pk,
      tenantFk: entity.tenantFk,
      name: entity.name,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
    context.putE(entity.pk, model);

    // Relationships
    return model.copyWith(
      tenant: context.getE<TenantModel>(entity.tenantFk) ?? (entity.tenant != null ? TenantModel.fromEntity(entity: entity.tenant!, context: context) : null),
      users: entity.users.map((e) => context!.getE<UserModel>(e.pk) ?? UserModel.fromEntity(entity: e, context: context)).toList(),
    );
  }
}

extension TeamModelX on TeamModel {
  TeamEntity toEntity() {
    return TeamEntity(
      pk: pk ?? 0,
      tenantFk: tenantFk ?? 0,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
      tenant: tenant?.toEntity(),
      users: users.map((e) => e.toEntity()).toList(),
    );
  }
}

@freezed
class BooksServiceModel with _$BooksServiceModel {
  const factory BooksServiceModel({
    int? pk,
    int? bookFk,
    int? serviceFk,
    @Default('') String name,
    @Default('') String desc,
    int? price,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationships
    BookModel? book,
    ServiceModel? service,
  }) = _BooksServiceModel;

  factory BooksServiceModel.fromEntity({
    required BooksServiceEntity entity,
    XContext? context,
  }) {
    context ??= XContext.of();

    var model = context.getE<BooksServiceModel>(entity.pk);
    if (model != null) {
      return model;
    }
    model = BooksServiceModel(
      pk: entity.pk,
      bookFk: entity.bookFk,
      serviceFk: entity.serviceFk,
      name: entity.name,
      desc: entity.desc,
      price: entity.price,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
    context.putE(entity.pk, model);

    // Relationships
    return model.copyWith(
      book: context.getE<BookModel>(entity.bookFk) ?? (entity.book != null ? BookModel.fromEntity(entity: entity.book!, context: context) : null),
      service: (() {
        if (entity.serviceFk == null) {
          return null;
        }

        return context!.getE<ServiceModel>(entity.serviceFk!) ?? (entity.service != null ? ServiceModel.fromEntity(entity: entity.service!, context: context) : null);
      })(),
    );
  }
}

extension BooksServiceModelX on BooksServiceModel {
  BooksServiceEntity toEntity() {
    return BooksServiceEntity(
      pk: pk ?? 0,
      bookFk: bookFk ?? 0,
      serviceFk: serviceFk ?? 0,
      name: name,
      desc: desc,
      price: price,
      createdAt: createdAt,
      updatedAt: updatedAt,
      book: book?.toEntity(),
      service: service?.toEntity(),
    );
  }
}

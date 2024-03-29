import 'package:collection/collection.dart';
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

// enum ArtifactType {
//   normal(nameJp: "ノーマル", color: 0xffaea886),
//   medium(nameJp: "ミディアム", color: 0xfff45c19),
//   large(nameJp: "ラージ", color: 0xff4a96d6),
//   huge(nameJp: "巨大", color: 0xff28b25c),
//   ;
//
//   final String nameJp;
//
//   final int color;
//   const ArtifactType({required this.nameJp, required this.color});
//
//   static ArtifactType? getOrNull(String name) {
//     const List<ArtifactType?> types = ArtifactType.values;
//     for (var element in types) {
//       if (element?.name == name) return element;
//     }
//     return null;
//   }
// }

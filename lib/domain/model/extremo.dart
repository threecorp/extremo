import 'package:extremo/io/entity/extremo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'extremo.freezed.dart';

@freezed
class ArtifactModel with _$ArtifactModel {
  const factory ArtifactModel({
    required int id,
    required int userFk,
    required String title,
    required String content,
    required String summary,
    required String status, // XXX: required ArtifactType status,
    DateTime? publishFrom,
    DateTime? publishUntil,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ArtifactModel;

  factory ArtifactModel.fromEntity({
    required ExtremoArtifactEntity entity,
  }) {
    // XXX: types: entity.types.map((type)
    //      => ArtifactType.getOrNull(type)).whereType<ArtifactType>().toList(),
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

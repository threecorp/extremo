// import 'package:collection/collection.dart';
import 'package:extremo/io/store/api/extremo/extremo_response.dart';
import 'package:hive/hive.dart';

part 'extremo.g.dart';

@HiveType(typeId: 1)
class ExtremoUserEntity {
  ExtremoUserEntity({
    required this.id,
    this.email = '',
    this.dateJoined,
    this.deletedAt,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExtremoUserEntity.from({
    required ExtremoUser element,
  }) {
    // final flavor = species.flavorTextEntries.lastWhereOrNull((element) {
    //   return element.language.name.startsWith("ja");
    // });
    return ExtremoUserEntity(
      id: element.pk,
      email: element.email ?? '',
      dateJoined: element.dateJoined,
      isDeleted: element.isDeleted,
      deletedAt: element.deletedAt,
      createdAt: element.createdAt,
      updatedAt: element.updatedAt,
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
  DateTime createdAt;

  @HiveField(6)
  DateTime updatedAt;
}

@HiveType(typeId: 2)
class ExtremoArtifactEntity {
  ExtremoArtifactEntity({
    required this.id,
    required this.userFk,
    this.user,
    this.title = '',
    this.content = '',
    this.summary = '',
    this.status = '', // TODO: Enum Type
    this.publishFrom,
    this.publishUntil,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExtremoArtifactEntity.from({
    required ExtremoArtifact element,
  }) {
    final user = element.user != null
        ? ExtremoUserEntity.from(element: element.user!)
        : null;

    return ExtremoArtifactEntity(
      id: element.pk,
      userFk: element.userFk,
      user: user,
      title: element.title,
      content: element.content,
      summary: element.summary,
      status: element.status,
      publishFrom: element.publishFrom,
      publishUntil: element.publishUntil,
      createdAt: element.createdAt,
      updatedAt: element.updatedAt,
    );
  }

  ExtremoUserEntity? user;

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
  DateTime createdAt;

  @HiveField(9)
  DateTime updatedAt;
}

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
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExtremoUserEntity.from({
    required ExtremoUser user,
  }) {
    // final flavor = species.flavorTextEntries.lastWhereOrNull((element) {
    //   return element.language.name.startsWith("ja");
    // });
    return ExtremoUserEntity(
      id: user.pk,
      email: user.email ?? '',
      dateJoined: user.dateJoined,
      isDeleted: user.isDeleted,
      deletedAt: user.deletedAt,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
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

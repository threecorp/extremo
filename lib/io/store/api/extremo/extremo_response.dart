import 'package:freezed_annotation/freezed_annotation.dart';

import '../converter.dart';

part 'extremo_response.g.dart';
part 'extremo_response.freezed.dart';

@Freezed(genericArgumentFactories: true)
class ExtremoGetResponse<T> with _$ExtremoGetResponse<T> {
  const factory ExtremoGetResponse({
    required T element,
  }) = _ExtremoGetResponse<T>;

  factory ExtremoGetResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ExtremoGetResponseFromJson<T>(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
class ExtremoListResponse<T> with _$ExtremoListResponse<T> {
  const factory ExtremoListResponse({
    required int totalSize,
    // TODO(next): String? next,
    // TODO(previous): String? previous,
    required List<T> elements,
  }) = _ExtremoListResponse<T>;

  factory ExtremoListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ExtremoListResponseFromJson<T>(json, fromJsonT);
}

@freezed
class ExtremoArtifact with _$ExtremoArtifact {
  const factory ExtremoArtifact({
    required int pk,
    required int userFk,
    ExtremoUser? user,
    required String title,
    required String content,
    required String summary,
    required String status, // TODO: Enum Type
    @DateTimeConverter() DateTime? publishFrom,
    @DateTimeConverter() DateTime? publishUntil,
    @DateTimeConverter() required DateTime createdAt,
    @DateTimeConverter() required DateTime updatedAt,
  }) = _ExtremoArtifact;

  factory ExtremoArtifact.fromJson(Map<String, dynamic> json) =>
      _$ExtremoArtifactFromJson(json);
}

@freezed
class ExtremoUser with _$ExtremoUser {
  const factory ExtremoUser({
    required int pk,
    String? email,
    String? password,
    required bool isDeleted,
    @DateTimeConverter() DateTime? deletedAt,
    @DateTimeConverter() DateTime? dateJoined,
    @DateTimeConverter() required DateTime createdAt,
    @DateTimeConverter() required DateTime updatedAt,
  }) = _ExtremoUser;

  factory ExtremoUser.fromJson(Map<String, dynamic> json) =>
      _$ExtremoUserFromJson(json);
}

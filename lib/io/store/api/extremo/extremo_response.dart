import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';

import '../converter.dart';

part 'extremo_response.g.dart';
part 'extremo_response.freezed.dart';

@Freezed(genericArgumentFactories: true)
class GetResponse<T> with _$GetResponse<T> {
  const factory GetResponse({
    required T element,
  }) = _GetResponse<T>;

  factory GetResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$GetResponseFromJson<T>(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
class ListResponse<T> with _$ListResponse<T> {
  const factory ListResponse({
    required int totalSize,
    // TODO(next): String? next,
    // TODO(previous): String? previous,
    required List<T> elements,
  }) = _ListResponse<T>;

  factory ListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ListResponseFromJson<T>(json, fromJsonT);
}

@freezed
class ArtifactResponse with _$ArtifactResponse {
  const factory ArtifactResponse({
    required int pk,
    required int userFk,
    required String title,
    required String content,
    required String summary,
    required String status, // TODO: Enum Type
    @DateTimeConverter() DateTime? publishFrom,
    @DateTimeConverter() DateTime? publishUntil,
    @DateTimeConverter() required DateTime createdAt,
    @DateTimeConverter() required DateTime updatedAt,
    // Relationship
    UserResponse? user,
  }) = _ArtifactResponse;

  factory ArtifactResponse.fromJson(Map<String, dynamic> json) =>
      _$ArtifactResponseFromJson(json);
}

@freezed
class UserResponse with _$UserResponse {
  const factory UserResponse({
    required int pk,
    String? email,
    String? password,
    required bool isDeleted,
    @DateTimeConverter() DateTime? deletedAt,
    @DateTimeConverter() DateTime? dateJoined,
    @DateTimeConverter() required DateTime createdAt,
    @DateTimeConverter() required DateTime updatedAt,
    // Relationship
    @Default([]) List<ArtifactResponse> artifacts,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}

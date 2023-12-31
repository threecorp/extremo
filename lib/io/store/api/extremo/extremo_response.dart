import 'package:freezed_annotation/freezed_annotation.dart';

import '../converter.dart';

part 'extremo_response.g.dart';
part 'extremo_response.freezed.dart';

@freezed
class ExtremoGetResponse with _$ExtremoGetResponse {
  const factory ExtremoGetResponse({
    required ExtremoUser user,
  }) = _ExtremoGetResponse;

  factory ExtremoGetResponse.fromJson(Map<String, dynamic> json) =>
      _$ExtremoGetResponseFromJson(json);
}

@freezed
class ExtremoListResponse with _$ExtremoListResponse {
  const factory ExtremoListResponse({
    required int totalSize,
    // TODO(next): String? next,
    // TODO(previous): String? previous,
    required List<ExtremoUser> users,
  }) = _ExtremoListResponse;

  factory ExtremoListResponse.fromJson(Map<String, dynamic> json) =>
      _$ExtremoListResponseFromJson(json);
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

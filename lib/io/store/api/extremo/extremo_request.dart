import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';

import '../converter.dart';

part 'extremo_request.g.dart';
part 'extremo_request.freezed.dart';

@freezed
class ArtifactRequest with _$ArtifactRequest {
  const factory ArtifactRequest({
    // int? pk,
    // required int userFk,
    required String title,
    @Default('') String summary,
    @Default('') String content,
    // required String status,
    @DateTimeConverter() DateTime? publishFrom,
    @DateTimeConverter() DateTime? publishUntil,
  }) = _ArtifactRequest;

  factory ArtifactRequest.fromJson(Map<String, dynamic> json) =>
      _$ArtifactRequestFromJson(json);
}

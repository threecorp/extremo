// import 'package:dio/dio.dart';
// import 'package:extremo/io/store/api/extremo/extremo_request.dart';
// import 'package:extremo/io/store/api/extremo/extremo_response.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:extremo/io/entity/extremo/extremo.dart';
import 'package:extremo/io/entity/paging.dart';
import 'package:extremo/io/store/api/extremo/auth.dart';
import 'package:extremo/io/store/api/extremo/mypage.dart';
import 'package:extremo/io/store/api/extremo/public.dart';
import 'package:extremo/io/store/db/extremo/box.dart';
import 'package:extremo/io/x/extremo/extremo.dart';
import 'package:extremo/misc/exception.dart';
import 'package:extremodart/extremo/api/mypage/artifacts/v1/artifact_service.pb.dart';
import 'package:extremodart/google/protobuf/timestamp.pb.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'artifact.g.dart';

// TODO(ClassBase): Transform to Class base
// TODO(offline): DBCache to use offline or error

@riverpod
Future<PagingEntity<ArtifactEntity>> repoListPagerArtifacts(
  RepoListPagerArtifactsRef ref,
  int page,
  int pageSize,
) async {
  final rpc = ref.read(mypageArtifactServiceClientProvider);

  // TODO(offline): Use DBCache when offlined or error
  final response = await rpc.list(
    ListRequest(
      page: page,
      pageSize: pageSize,
    ),
  );
  final elements = await Future.wait(
    response.elements.map(
      (element) => xFormRpcArtifactEntity(ref, element),
    ),
  );

  return PagingEntity<ArtifactEntity>(
    elements: elements.toList(),
    totalSize: response.totalSize,
  );
}

@riverpod
Future<Result<ArtifactEntity, Exception>> repoGetArtifact(
  RepoGetArtifactRef ref,
  int id,
) async {
  final rpc = ref.read(mypageArtifactServiceClientProvider);

  // TODO(offline): Use DBCache when offlined or error
  final entity = await rpc.get(GetRequest(pk: id)).then(
        (r) => xFormRpcArtifactEntity(ref, r.element),
      );

  return Success(entity);
}

@riverpod
Future<Result<ArtifactEntity, Exception>> repoCreateArtifact(
  RepoCreateArtifactRef ref,
  ArtifactEntity request,
) async {
  final rpc = ref.read(mypageArtifactServiceClientProvider);

  try {
    final entity = await rpc
        .create(
          CreateRequest(
            title: request.title,
            summary: request.summary,
            content: request.content,
            publishFrom: request.publishFrom != null ? Timestamp.fromDateTime(request.publishFrom!) : null,
            publishUntil: request.publishUntil != null ? Timestamp.fromDateTime(request.publishUntil!) : null,
          ),
        )
        .then(
          (r) => xFormRpcArtifactEntity(ref, r.element),
        );

    return Success(entity);
  } on GrpcError catch (ex, _) {
    if ([StatusCode.invalidArgument].contains(ex.code)) {
      return Failure(GrpcException(ex));
    }

    debugPrint(ex.message);
    rethrow;
  }
}

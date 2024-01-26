// import 'package:dio/dio.dart';
// import 'package:extremo/io/store/api/extremo/extremo_request.dart';
// import 'package:extremo/io/store/api/extremo/extremo_response.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:extremo/io/entity/extremo/extremo.dart';
import 'package:extremo/io/entity/paging.dart';
import 'package:extremo/io/store/api/extremo/extremo.dart';
import 'package:extremo/io/store/db/extremo/extremo_box.dart';
import 'package:extremo/io/x/extremo/extremo.dart';
import 'package:extremo/misc/result.dart';
import 'package:extremodart/extremo/api/mypage/artifacts/v1/artifact_service.pb.dart';
import 'package:extremodart/google/protobuf/timestamp.pb.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'extremo.g.dart';

// TODO(ClassBase): Transform to Class base
// TODO(offline): DBCache to use offline or error

@riverpod
Future<List<UserEntity>> dbListUsersByIds(
  DbListUsersByIdsRef ref,
  List<int> ids,
) async {
  final userBox = await ref.read(userBoxProvider.future);
  final publicApi = ref.read(publicApiProvider);

  Future<UserEntity?> getter(int id) async {
    final entity = userBox.get(id);
    if (entity != null) {
      return entity;
    }

    final response = await publicApi.getUser(id);
    final result = UserEntity.fromResponse(element: response.element);

    await userBox.put(id, result);
    return result;
  }

  return Future.wait(ids.map((id) => getter(id).onNotFoundErrorToNull()))
      .then((list) => list.whereType<UserEntity>().toList());
}

@riverpod
Future<PagingEntity<ArtifactEntity>> dbListPagerArtifacts(
  DbListPagerArtifactsRef ref,
  int page,
  int pageSize,
) async {
  final rpc = ref.read(mypageArtifactServiceClientProvider);

  // TODO(offline): Use DBCache when offlined or error
  final response = await rpc.list(
    ListRequest()
      ..page = page
      ..pageSize = pageSize,
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
Future<Result<ArtifactEntity>> dbGetArtifact(
  DbGetArtifactRef ref,
  int id,
) async {
  final rpc = ref.read(mypageArtifactServiceClientProvider);

  // TODO(offline): Use DBCache when offlined or error
  final entity = await rpc.get(GetRequest()..pk = id).then(
        (r) => xFormRpcArtifactEntity(ref, r.element),
      );

  return Success(entity);
}

@riverpod
Future<Result<ArtifactEntity>> dbCreateArtifact(
  DbCreateArtifactRef ref,
  ArtifactEntity request,
) async {
  final rpc = ref.read(mypageArtifactServiceClientProvider);

  // print('aaaaaaaaaaa');
  // print(request.title);
  // print(request.summary);
  // print(request.content);
  // print(request.publishFrom);
  // print(request.publishUntil);

  try {
    final entity = await rpc
        .create(
          CreateRequest(
            title: request.title,
            summary: request.summary,
            content: request.content,
            publishFrom: request.publishFrom != null
                ? Timestamp.fromDateTime(request.publishFrom!)
                : null,
            publishUntil: request.publishUntil != null
                ? Timestamp.fromDateTime(request.publishUntil!)
                : null,
          ),
        )
        .then(
          (r) => xFormRpcArtifactEntity(ref, r.element),
        );

    return Success(entity);
  } on GrpcError catch (ex, stack) {
    if (ex.code == StatusCode.invalidArgument) {
      //
      // TODO(Refactoring): Parse response validation message
      //
      // ex.response!.data.map(
      //   (e) => e as Map<String, dynamic>,
      // ).forEach(
      //   (e) => print(e),
      // );
      debugPrint(ex.message);
      return Failure(ex.message ?? '', stack);
    }

    rethrow;
  }
}
//
//
//

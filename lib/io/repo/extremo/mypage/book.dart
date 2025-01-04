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
import 'package:extremo/misc/logger.dart';
import 'package:extremodart/extremo/api/mypage/books/v1/book_service.pb.dart' as bookpb;
import 'package:extremodart/google/protobuf/timestamp.pb.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book.g.dart';

@riverpod
Future<PagingEntity<BookEntity>> repoListPagerBooks(
  RepoListPagerBooksRef ref,
  int tenantFk,
  int page,
  int pageSize,
) async {
  final rpc = ref.read(mypageBookServiceClientProvider);

  // TODO(offline): Use DBCache when offlined or error
  final response = await rpc.list(
    bookpb.ListRequest(
      tenantFk: tenantFk,
      page: page,
      pageSize: pageSize,
    ),
  );
  final elements = await Future.wait(
    response.elements.map(
      (element) => xFormRpcBookEntity(ref, element),
    ),
  );

  return PagingEntity<BookEntity>(
    elements: elements.toList(),
    totalSize: response.totalSize,
  );
}

@riverpod
Future<Result<BookEntity, Exception>> repoGetBook(
  RepoGetBookRef ref,
  int id,
) async {
  final rpc = ref.read(mypageBookServiceClientProvider);

  // TODO(offline): Use DBCache when offlined or error
  final entity = await rpc.get(bookpb.GetRequest(pk: id)).then(
        (r) => xFormRpcBookEntity(ref, r.element),
      );

  return Success(entity);
}

@riverpod
Future<Result<BookEntity, Exception>> repoCreateBook(
  RepoCreateBookRef ref,
  BookEntity request,
) async {
  final rpc = ref.read(mypageBookServiceClientProvider);

  try {
    final entity = await rpc
        .create(
          bookpb.CreateRequest(
            tenantFk: request.tenantFk,
            // summary: request.summary,
            // content: request.content,
            // publishFrom: request.publishFrom != null ? Timestamp.fromDateTime(request.publishFrom!) : null,
            // publishUntil: request.publishUntil != null ? Timestamp.fromDateTime(request.publishUntil!) : null,
          ),
        )
        .then(
          (r) => xFormRpcBookEntity(ref, r.element),
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

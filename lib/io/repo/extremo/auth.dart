// import 'package:dio/dio.dart';
// import 'package:extremo/io/store/api/extremo/extremo_request.dart';
// import 'package:extremo/io/store/api/extremo/extremo_response.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:extremo/io/entity/extremo/extremo.dart';
import 'package:extremo/io/entity/paging.dart';
import 'package:extremo/io/store/api/extremo/auth.dart';
import 'package:extremo/io/store/db/extremo/box.dart';
import 'package:extremo/io/x/extremo/extremo.dart';
import 'package:extremo/misc/exception.dart';
import 'package:extremodart/extremo/api/auth/accounts/v1/account_service.pb.dart';
import 'package:extremodart/extremo/msg/api/v1/api.pb.dart';
import 'package:extremodart/google/protobuf/timestamp.pb.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth.g.dart';

@riverpod
Future<Result<AccountToken, Exception>> repoLogin(
  RepoLoginRef ref,
  LoginRequest request,
) async {
  final rpc = ref.read(authAccountServiceClientProvider);

  try {
    // TODO(offline): Use DBCache when offlined or error
    final entity = await rpc.login(request).then((r) => r.element); // TODO(Refactoring): Transform & Cache?

    return Success(entity);
  } on GrpcError catch (ex, _) {
    if ([
      StatusCode.invalidArgument,
      StatusCode.unauthenticated,
    ].contains(ex.code)) {
      return Failure(GrpcException(ex));
    }

    debugPrint(ex.message);
    rethrow;
  }
}

@riverpod
Future<Result<AccountToken, Exception>> repoRegister(
  RepoRegisterRef ref,
  RegisterRequest request,
) async {
  final rpc = ref.read(authAccountServiceClientProvider);

  try {
    // TODO(offline): Use DBCache when offlined or error
    final entity = await rpc.register(request).then((r) => r.element); // TODO(Refactoring): Transform & Cache?

    return Success(entity);
  } on GrpcError catch (ex, _) {
    if ([
      StatusCode.invalidArgument,
      StatusCode.unauthenticated,
    ].contains(ex.code)) {
      return Failure(GrpcException(ex));
    }

    debugPrint(ex.message);
    rethrow;
  }
}

@riverpod
Future<Result<Account, Exception>> repoGetAccountByToken(
  RepoGetAccountByTokenRef ref,
  String token,
) async {
  final rpc = ref.read(authAccountServiceClientProvider);

  // TODO(offline): Use DBCache when offlined or error
  final entity = await rpc.getAccountByToken(GetAccountByTokenRequest(token: token)).then(
        (r) => r.element, // TODO(Refactoring): Transform & Cache?
      );

  return Success(entity);
}
//
//
//

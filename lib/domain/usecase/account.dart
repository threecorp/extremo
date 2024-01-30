import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/io/repo/extremo/auth.dart';
import 'package:extremodart/extremo/api/auth/accounts/v1/account_service.pb.dart';
import 'package:extremodart/extremo/msg/api/v1/api.pb.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// import './util.dart';

part 'account.g.dart';

// TODO(ClassBase): Transform to Class base

@riverpod
Future<Result<Account, Exception>> loginAccountCase(
  LoginAccountCaseRef ref,
  LoginRequest request,
) async {
  final result = ref.read(
    repoLoginProvider(request).future,
  );

  return result.flatMap(
    (AccountToken e) async => await ref.read(
      repoGetAccountByTokenProvider(e.token).future,
    ),
  );
}

@riverpod
Future<Result<AccountToken, Exception>> loginTokenCase(
  LoginTokenCaseRef ref,
  LoginRequest request,
) async {
  final result = await ref.read(
    repoLoginProvider(request).future,
  );

  return result;
}
//
//
//

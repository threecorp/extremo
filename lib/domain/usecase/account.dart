import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/io/repo/extremo/auth.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:extremodart/extremo/msg/api/v1/api.pb.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// import './util.dart';

part 'account.g.dart';

// TODO(ClassBase): Transform to Class base

@riverpod
Future<Result<Account>> login(
  LoginRef ref,
  String email,
  String password,
) async {
  final result = await ref.read(
    repoLoginProvider(email, password).future,
  );
  // if (result is Failure) {
  //   return result;
  // }
  //
  // result.getOrThrow
  //
  // final token = result.getOrNull;
  // if (token != null) {
  //   return Failure(e.error, e.stackTrace);
  // }
  //
  //     final account = await ref.read(
  //       repoGetAccountByTokenProvider(e.value.token).future,
  //     );

  return result.map(
    success: (e) async {
      final account = await ref.read(
        repoGetAccountByTokenProvider(e.value.token).future,
      );

      final value = account.getOrNull!;
      return Success(value);
    },
    failure: (e) => Failure(e.error, e.stackTrace),
  );
}
//
//
//

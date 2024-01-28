import 'package:collection/collection.dart';
import 'package:extremo/io/store/secure/extremo/account.dart';
import 'package:extremodart/extremo/msg/api/v1/api.pb.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account.g.dart';


@riverpod
class Account extends _$Account {
  @override
  Future<AccountToken?> build() async {
    final token = await ref.read(accountSecureStorageProvider).find();
    return token != null ? AccountToken.fromJson(token) : null;
  }

  Future<void> login(AccountToken token) async {
    await ref.read(accountSecureStorageProvider).store(token.writeToJson());
    state = AsyncValue.data(token);
  }

  Future<void> logout() async {
    await ref.read(accountSecureStorageProvider).remove();
    state = const AsyncValue.data(null);
  }

  AccountToken? token() {
    return state.value;
  }

  bool isLoggedIn() {
    return token() != null;
  }
}

// import 'package:collection/collection.dart';
// import 'package:extremo/misc/logger.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:extremo/io/repo/extremo/auth.dart';
import 'package:extremo/io/store/secure/extremo/account.dart';
import 'package:extremodart/extremo/msg/api/v1/api.pb.dart' as apipb;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account.g.dart';
part 'account.freezed.dart';

@freezed
class AccountState with _$AccountState {
  const factory AccountState({
    required apipb.AccountToken? token,
    required apipb.Account? account,
  }) = _AccountState;
}

@riverpod
class Account extends _$Account {
  @override
  Future<AccountState> build() async {
    final token = await ref.read(accountSecureStorageProvider).find();
    if (token == null) {
      return const AccountState(token: null, account: null);
    }

    final accountToken = apipb.AccountToken.fromJson(token);
    final account = await _getAccount(accountToken);

    return AccountState(token: accountToken, account: account);
  }

  Future<void> login(apipb.AccountToken token) async {
    await ref.read(accountSecureStorageProvider).store(token.writeToJson());
    final account = await _getAccount(token);

    state = AsyncValue.data(AccountState(token: token, account: account));
  }

  Future<void> logout() async {
    await ref.read(accountSecureStorageProvider).remove();
    state = const AsyncValue.data(AccountState(token: null, account: null));
  }

  AccountState? stateValue() {
    return state.value;
  }

  apipb.AccountToken? token() {
    return state.value?.token;
  }

  bool isLoggedIn() {
    return token() != null;
  }

  Future<apipb.Account?> _getAccount(apipb.AccountToken accountToken) async {
    final accountResult = await ref.read(
      repoGetAccountByTokenProvider(accountToken.token).future,
    );
    return accountResult.fold(
      (account) => account,
      (error) => null, // TODO(refectoring): Logging
    );
  }

  Future<void> fetchAccount() async {
    final currentState = state.value;
    if (currentState == null) {
      return;
    }
    final currentToken = currentState.token;
    if (currentToken == null) {
      return;
    }
    final account = await _getAccount(currentToken);

    state = AsyncValue.data(
      AccountState(token: currentState.token, account: account),
    );
  }

  apipb.Account? account() {
    return state.value?.account;
  }
}

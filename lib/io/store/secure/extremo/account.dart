import 'package:collection/collection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account.g.dart';

class AccountSecureStorage {
  AccountSecureStorage({required this.ref});
  final AccountSecureStorageRef ref;

  final _storage = const FlutterSecureStorage();
  final _key = 'extremoAccountSecureStorage';

  Future<void> store(String token) async {
    await _storage.write(key: _key, value: token);
  }

  Future<String?> find() async {
    return _storage.read(key: _key);
  }

  Future<void> remove() async {
    await _storage.delete(key: _key);
  }
}

@riverpod
AccountSecureStorage accountSecureStorage(AccountSecureStorageRef ref) {
  return AccountSecureStorage(ref: ref);
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure.g.dart';

class AccountSecureStorage {
  final _storage = const FlutterSecureStorage();
  final _key = 'extremoAccountSecureStorage';

  Future<void> saveToken(String token) async {
    await _storage.write(key: _key, value: token);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _key);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _key);
  }
}

@riverpod
AccountSecureStorage accountSecureStorage(AccountSecureStorageRef ref) {
  return AccountSecureStorage();
}

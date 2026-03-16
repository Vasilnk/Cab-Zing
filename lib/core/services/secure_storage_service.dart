import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  Future<void> saveToSecureStorage(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readFromSecureStorage(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> deleteFromSecureStorage(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAllFromSecureStorage() async {
    await _storage.deleteAll();
  }
}

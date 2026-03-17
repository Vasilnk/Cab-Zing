import 'package:cab_zing/core/constants/api_constants.dart';
import 'package:cab_zing/core/services/secure_storage_service.dart';
import 'package:cab_zing/features/auth/models/auth_response_model.dart';
import 'package:dio/dio.dart';

class AuthService {
  final SecureStorageService storageService;

  AuthService(this.storageService);

  Future<void> login(String username, String password) async {
    final url = '${ApiConstants.accountsBaseUrl}${ApiConstants.loginEndpoint}';
    final response = await Dio().post(
      url,
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: {'username': username, 'password': password, 'is_mobile': true},
    );

    if (response.statusCode == 200) {
      final resData = AuthResponseModel.fromJson(response.data);
      if (resData.success == 6000 && resData.access != null && resData.refresh != null) {
        await storageService.saveToSecureStorage('access_token', resData.access!);
        await storageService.saveToSecureStorage('refresh_token', resData.refresh!);
        if (resData.userId != null) {
          await storageService.saveToSecureStorage('user_id', resData.userId!);
        }
      } else {
        throw Exception(resData.error ?? resData.message ?? 'Login failed');
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await storageService.readFromSecureStorage('access_token');
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await storageService.deleteAllFromSecureStorage();
  }
}

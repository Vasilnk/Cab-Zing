import 'package:cab_zing/core/constants/api_constants.dart';
import 'package:cab_zing/core/services/secure_storage_service.dart';
import 'package:cab_zing/features/auth/models/auth_response_model.dart';
import 'package:dio/dio.dart';

class AuthService {
  final SecureStorageService _storageService;

  AuthService(this._storageService);
  //
  //
  // This is the func for login user
  //
  //
  //
  Future<void> login(String username, String password) async {
    final url = '${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}';
    final response = await Dio().post(
      url,
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: {'username': username, 'password': password, 'is_mobile': true},
    );

    if (response.statusCode == 200) {
      final resData = AuthResponseModel.fromJson(response.data);

      if (resData.success == 6000 &&
          resData.access != null &&
          resData.refresh != null) {
        await _storageService.saveToSecureStorage(
          'access_token',
          resData.access!,
        );
        await _storageService.saveToSecureStorage(
          'refresh_token',
          resData.refresh!,
        );
        if (resData.userId != null) {
          await _storageService.saveToSecureStorage('user_id', resData.userId!);
        }
      } else {
        throw Exception(resData.error ?? resData.message ?? 'Login failed');
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  //
  //
  // Check if user is logged in
  // To make sure user is logged in and navigate to dashboard
  //
  //
  Future<bool> isLoggedIn() async {
    final token = await _storageService.readFromSecureStorage('access_token');
    return token != null && token.isNotEmpty;
  }

  //
  //
  // Logout user
  //
  //
  //
  Future<void> logout() async {
    await _storageService.deleteAllFromSecureStorage();
  }
}

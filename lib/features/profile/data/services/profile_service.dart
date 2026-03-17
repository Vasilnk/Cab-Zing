import 'package:cab_zing/core/constants/api_constants.dart';
import 'package:cab_zing/core/services/secure_storage_service.dart';
import 'package:cab_zing/features/profile/models/profile_model.dart';
import 'package:dio/dio.dart';

class ProfileService {
  final SecureStorageService storageService;
  final Dio _dio = Dio();

  ProfileService(this.storageService);

  Future<ProfileModel> fetchProfile() async {
    final token = await storageService.readFromSecureStorage('access_token');
    final userId = await storageService.readFromSecureStorage('user_id');

    if (token == null || userId == null) {
      throw Exception('Authentication required');
    }

    final url = '${ApiConstants.viknBooksBaseUrl}${ApiConstants.userViewEndpoint}$userId/';
    
    final response = await _dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      if (response.data['StatusCode'] == 6000) {
        return ProfileModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load profile: ${response.data['message'] ?? 'Unknown error'}');
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }
}

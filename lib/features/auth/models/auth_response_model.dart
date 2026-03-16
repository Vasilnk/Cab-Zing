class AuthResponseModel {
  final int success;
  final String? access;
  final String? refresh;
  final String? userId;
  final String? error;
  final String? message;

  AuthResponseModel({
    required this.success,
    this.access,
    this.refresh,
    this.userId,
    this.error,
    this.message,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    return AuthResponseModel(
      success: json['success'] ?? 0,
      access: data?['access'] as String?,
      refresh: data?['refresh'] as String?,
      userId: (data?['user_id'] ?? json['user_id'])?.toString(),
      error: json['error'] as String?,
      message: json['message'] as String?,
    );
  }
}

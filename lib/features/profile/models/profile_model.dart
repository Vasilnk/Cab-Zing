class ProfileModel {
  final String firstName;
  final String lastName;
  final String email;
  final String profileImage;

  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImage,
  });

  String get fullName => '$firstName $lastName';

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final userData = json['data'] ?? {};
    final customerData = json['customer_data'] ?? {};
    return ProfileModel(
      firstName: userData['first_name'] ?? '',
      lastName: userData['last_name'] ?? '',
      email: userData['email'] ?? '',
      profileImage: customerData['photo'] ?? '',
    );
  }
}

class LoginModel {
  final String access;
  final String refresh;
  final String role;

  LoginModel({required this.access, required this.refresh, required this.role});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      access: json['access'] as String,
      refresh: json['refresh'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'access': access, 'refresh': refresh, 'role': role};
  }
}

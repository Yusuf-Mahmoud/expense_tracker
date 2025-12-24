class UserModel {
  String password;
  final String name;
  final String email;
  final String? photoUrl;
  final String currency;
  final DateTime createdAt;

  UserModel({
    required this.password, 
    required this.name,
    required this.email,
    this.photoUrl,
    required this.currency,
    required this.createdAt,
  });
  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'currency': currency,
      'createdAt': createdAt.toIso8601String(),
    };
  }
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      password: json['password'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      currency: json['currency'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

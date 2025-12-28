class UserModel {
  String password;
  final String name;
  final String email;
  final String photoUrl;
  

  UserModel({
    required this.password,
    required this.name,
    required this.email,
    String? photoUrl,
    
  }) : photoUrl = photoUrl ?? '';

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      password: json['password'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      
    );
  }
}

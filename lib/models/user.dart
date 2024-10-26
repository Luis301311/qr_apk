class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final bool isActive;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.isActive,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      isActive: json['isActive'],
      token: json['token'],
    );
  }
}

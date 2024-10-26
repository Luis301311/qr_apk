class User {
  String id;
  String password;
  String name;
  String lastname;
  String email;
  String cohort1;
  String course1;
  String type1;
  String city;
  String country;

  User({
    required this.id,
    required this.password,
    required this.name,
    required this.lastname,
    required this.email,
    required this.cohort1,
    required this.course1,
    required this.type1,
    required this.city,
    required this.country,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      password: json['password'] ?? '',
      name: json['name'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      cohort1: json['cohort1'] ?? '',
      course1: json['course1'] ?? '',
      type1: json['type1'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
    );
  }
}

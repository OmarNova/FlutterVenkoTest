
class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String avatar;
  final String? job;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.avatar,
    this.job, 
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['first_name'],
      lastname: json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}
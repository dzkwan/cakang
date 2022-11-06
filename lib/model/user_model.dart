class User {
  int id;
  String fullname;
  String username;
  String email;
  String password;
  String phone;
  String city;
  List category;

  User({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.city,
    required this.category,
  });
}
class Auth {
  String username;
  String password;

  Auth({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }
}
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.token,
});

  Map<String,dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      'password': password,
      'token': token,
    };
  }

  factory User.formMap(Map<String,dynamic> map){
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory User.formJson(String source) => User.formMap(json.decode(source));

}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class userRegis {
  final String name;
  final String lastName;
  final String tell;
  final String password;
  final String email;

  userRegis({required this.name, required this.lastName, required this.tell, required this.password, required this.email});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lastName': lastName,
      'tell': tell,
      'password': password,
      'email': email,
    };
  }

  factory userRegis.fromMap(Map<String, dynamic> map) {
    return userRegis(
      name: map['name'] as String,
      lastName: map['lastName'] as String,
      tell: map['tell'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory userRegis.fromJson(String source) => userRegis.fromMap(json.decode(source) as Map<String, dynamic>);
}

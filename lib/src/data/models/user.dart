import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.email,
    this.id,
    this.password,
    this.username,
    this.token,
  });

  final String id;
  final String email;
  final String password;
  final String username;
  final String token;

  @override
  List<Object> get props => [id, email, password, username, token];

  static const empty = User(username: 'some name');

  static User fromJson(dynamic json) {
    // final userInfo = json['user'];
    // final token = json['token'];
    return User(
        // id: userInfo['_id'],
        // email: userInfo['email'],
        // password: userInfo['password'],
        // username: userInfo['firstName'],
        token: json['token']);
  }
}

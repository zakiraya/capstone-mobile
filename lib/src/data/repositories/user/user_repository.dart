import 'dart:async';

import 'package:capstone_mobile/src/data/repositories/user/userApi.dart';
import '../../models/models.dart';

class UserRepository {
  User _user;
  final UserApi userApi;

  UserRepository({this.userApi});

  Future<User> getUser(email, password) async {
    return _user =
        _user != null ? _user : await userApi.signIn(email, password);
  }
}

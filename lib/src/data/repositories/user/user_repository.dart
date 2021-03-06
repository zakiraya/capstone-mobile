import 'dart:async';

import 'package:capstone_mobile/src/data/repositories/user/user_api.dart';
import '../../models/models.dart';

class UserRepository {
  User _user;
  final UserApi userApi;

  UserRepository({this.userApi});

  Future<User> getUser(String token) async {
    return _user = _user != null
        ? _user
        : await userApi.getProfile(
            token,
          );
  }

  // Future<User> getUser() async {
  //   if (_user != null) return _user;
  //   return Future.delayed(
  //     const Duration(milliseconds: 300),
  //     () => _user = User(id: Uuid().v4()),
  //   );
  // }
}

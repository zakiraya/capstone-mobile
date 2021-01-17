import 'package:capstone_mobile/src/data/repositories/authentication/authentication_repository.dart';
import 'package:capstone_mobile/src/data/repositories/user/userApi.dart';
import 'package:capstone_mobile/src/data/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(
      userApi: UserApi(
        httpClient: http.Client(),
      ),
    ),
    userRepository: UserRepository(
      userApi: UserApi(
        httpClient: http.Client(),
      ),
    ),
  ));
}

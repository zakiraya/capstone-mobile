import 'package:capstone_mobile/src/data/repositories/authentication/authentication_repository.dart';
import 'package:capstone_mobile/src/data/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

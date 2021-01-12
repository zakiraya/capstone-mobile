import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/data/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationBloc(),
    userRepository: UserRepository(),
  ));
}

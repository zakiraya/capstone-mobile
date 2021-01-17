import 'dart:async';

import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:meta/meta.dart';

import 'package:capstone_mobile/src/data/repositories/user/userApi.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class SignUpFailure implements Exception {}

class SignInFailure implements Exception {}

class AuthenticationRepository {
  final _controller = StreamController<String>();
  final UserApi userApi;

  AuthenticationRepository({@required this.userApi}) : assert(userApi != null);

  // Stream<AuthenticationStatus> get status async* {
  //   await Future<void>.delayed(const Duration(seconds: 1));
  //   yield AuthenticationStatus.unauthenticated;
  //   yield* _controller.stream;
  // }

  Stream<String> get token async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield '';
    yield* _controller.stream;
  }

  Future<void> signIn({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);

    try {
      final user = await userApi.signIn(username, password);
      user != null ? _controller.add(user.token) : _controller.add('');
    } catch (e) {
      print(e);
      // SignInFailure();
    }

    // await Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => _controller.add(AuthenticationStatus.authenticated),
    // );
  }

  void logOut() {
    _controller.add('');
  }

  void dispose() => _controller.close();
}

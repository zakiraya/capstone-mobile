import 'dart:async';

import 'package:meta/meta.dart';

import 'package:capstone_mobile/src/data/repositories/user/userApi.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class SignUpFailure implements Exception {}

class SignInFailure implements Exception {}

class AuthenticationRepository {
  final _controller = StreamController<String>();
  final UserApi userApi;

  AuthenticationRepository({@required this.userApi}) : assert(userApi != null);

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
      // final token = await userApi.signIn(username, password);
      final token = 'authen_repo';
      print('token: ' + token);
      token != '' ? _controller.add(token) : null;
    } catch (e) {
      SignInFailure();
    }
  }

  void logOut() {
    _controller.add('');
  }

  void dispose() => _controller.close();
}

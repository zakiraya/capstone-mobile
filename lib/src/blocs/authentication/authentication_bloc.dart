import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:capstone_mobile/src/data/models/models.dart';
import 'package:capstone_mobile/src/data/repositories/authentication/authentication_repository.dart';
import 'package:capstone_mobile/src/data/repositories/user/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
    @required UserRepository userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.token.listen(
      (token) => add(AuthenticationStatusChanged(token: token)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  StreamSubscription<String> _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  // Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
  //   AuthenticationStatusChanged event,
  // ) async {
  //   switch (event.status) {
  //     case AuthenticationStatus.unauthenticated:
  //       return const AuthenticationState.unauthenticated();
  //     case AuthenticationStatus.authenticated:
  //       final user = await _tryGetUser();
  //       return user != null
  //           ? AuthenticationState.authenticated(user)
  //           : const AuthenticationState.unauthenticated();
  //     default:
  //       return const AuthenticationState.unknown();
  //   }
  // }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    if (event.token == '') {
      return const AuthenticationState.unauthenticated();
    } else {
      final user = await _tryGetUser();
      return user != null
          ? AuthenticationState.authenticated(user)
          : const AuthenticationState.unauthenticated();
    }
  }

  Future<User> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser("admin", "123456");
      return user;
    } on Exception {
      return null;
    }
  }
}

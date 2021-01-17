part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged({this.token});

  final String token;

  @override
  List<Object> get props => [token];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({this.user = User.empty, this.token = ''});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user, String token)
      : this._(
            // status: AuthenticationStatus.authenticated,
            user: user,
            token: token);

  const AuthenticationState.unauthenticated() : this._(token: '');

  final User user;
  final String token;

  @override
  List<Object> get props => [user, token];
}

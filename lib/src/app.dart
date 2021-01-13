import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/data/repositories/authentication/authentication_repository.dart';
import 'package:capstone_mobile/src/data/repositories/user/user_repository.dart';
import 'package:capstone_mobile/src/ui/screens/home_screen.dart';
import 'package:capstone_mobile/src/ui/screens/login_screen.dart';
import 'package:capstone_mobile/src/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomeScreen.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginScreen.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}

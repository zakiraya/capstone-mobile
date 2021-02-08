import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/data/repositories/authentication/authentication_repository.dart';
import 'package:capstone_mobile/src/data/repositories/user/user_repository.dart';
import 'package:capstone_mobile/src/ui/screens/home_screen.dart';
import 'package:capstone_mobile/src/ui/screens/login_screen.dart';
import 'package:capstone_mobile/src/ui/screens/splash_screen.dart';
import 'package:capstone_mobile/src/ui/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
    var blue = Color(0xff2329D6);
    var purple = Color(0xffAA1EFF);
    var themeData = ThemeData(
      primaryColor: Colors.pink,
      // accentColor: Colors.purple[400],

      // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //   selectedItemColor: ,
      //   // backgroundColor: Colors.deepPurple,
      // ),

      fontFamily: 'Montserrat',

      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(fontSize: 20.0),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        button:
            TextStyle(fontSize: 16, letterSpacing: 1.5, color: Colors.white),
      ),
    );

    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.token != '') {
              _navigator.pushAndRemoveUntil<void>(
                HomeScreen.route(),
                (route) => false,
              );
            } else {
              _navigator.pushAndRemoveUntil<void>(
                LoginScreen.route(),
                (route) => false,
              );
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}

import 'package:capstone_mobile/src/blocs/login/login_bloc.dart';
import 'package:capstone_mobile/src/data/repositories/authentication/authentication_repository.dart';
import 'package:capstone_mobile/src/ui/widgets/login/login_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}

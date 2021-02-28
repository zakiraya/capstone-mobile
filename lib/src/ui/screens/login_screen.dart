import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:capstone_mobile/src/blocs/login/login_bloc.dart';
import 'package:capstone_mobile/src/data/repositories/authentication/authentication_repository.dart';
import 'package:capstone_mobile/src/ui/widgets/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text('Login'),
      // ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: size.width,
            minHeight: size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   width: size.width * 0.3,
                //   height: size.width * 0.2,
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       width: 1,
                //     ),
                //     borderRadius: BorderRadius.circular(2),
                //     image: DecorationImage(
                //       image: AssetImage('assets/logo.png'),
                //     ),
                //   ),
                // ),
                Container(
                  width: size.width * 0.4,
                  height: size.width * 0.2,
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.4,
                  height: size.width * 0.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/brand_name.png'),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Manage via camera',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                BlocProvider(
                  create: (context) {
                    return LoginBloc(
                      authenticationRepository:
                          RepositoryProvider.of<AuthenticationRepository>(
                              context),
                    );
                  },
                  child: LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

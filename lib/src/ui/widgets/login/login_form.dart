import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capstone_mobile/src/blocs/login/login_bloc.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Padding(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _UsernameInput(),
              _PasswordInput(),
              // _ErrorText(),
              SizedBox(height: 40),
              _LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

// class _ErrorText extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginBloc, LoginState>(
//       builder: (context, state) {
//         if (state.status.isSubmissionSuccess) {
//           return BlocBuilder<AuthenticationBloc, AuthenticationState>(
//             builder: (context, state) {
//               if (state.status == AuthenticationStatus.unauthenticated) {
//                 return Container(
//                   child: Text(
//                     'Login failed!',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 );
//               }
//               return Container();
//             },
//           );
//         }
//         return Container();
//       },
//     );
// //   }
// }

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Container(
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            keyboardType: TextInputType.emailAddress,
            onChanged: (username) =>
                context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            decoration: InputDecoration(
              hintText: 'example@com.vn',
              errorText: state.username.invalid ? 'Invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  __PasswordInputState createState() => __PasswordInputState();
}

class __PasswordInputState extends State<_PasswordInput> {
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            obscureText: isObscured,
            decoration: InputDecoration(
                hintText: 'password',
                errorText: state.password.invalid ? 'Invalid Password' : null,
                suffixIcon: IconButton(
                  iconSize: 16,
                  icon: Icon(Icons.remove_red_eye_sharp),
                  onPressed: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                )),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 104),
                child: ElevatedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.white,
                      // letterSpacing: 1.5,
                    ),
                  ),
                  onPressed: state.status.isValidated
                      ? () {
                          context.read<LoginBloc>().add(const LoginSubmitted());
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    elevation: 10.0,
                    onPrimary: Colors.red,
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              );
      },
    );
  }
}

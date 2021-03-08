import 'package:capstone_mobile/src/ui/utils/custom_text_field.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:capstone_mobile/src/blocs/change_password/change_password_cubit.dart';
import 'package:capstone_mobile/src/data/repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/data/repositories/authentication/authentication_repository.dart';
import 'package:capstone_mobile/src/data/repositories/user/user_api.dart';
import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ChangePasswordScreen());
  }

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ChangePasswordCubit(
          userRepository:
              UserRepository(userApi: UserApi(httpClient: http.Client()))),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: theme.scaffoldBackgroundColor,
          title: Text(
            'Change password',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            iconSize: 16.0,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: _ChangePasswordForm(),
        ),
      ),
    );
  }
}

class _ChangePasswordForm extends StatefulWidget {
  const _ChangePasswordForm({
    Key key,
  }) : super(key: key);

  @override
  __ChangePasswordFormState createState() => __ChangePasswordFormState();
}

class __ChangePasswordFormState extends State<_ChangePasswordForm> {
  bool isConfirmed = false;
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordRequested>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              text: "Success",
            ).then((value) {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            });
          }
          if (state.status.isSubmissionFailure) {
            Navigator.pop(context);
            CoolAlert.show(
                    context: context,
                    type: CoolAlertType.error,
                    title: "Oops...",
                    text: 'Your current password is not valid!')
                .then((value) {});
          }
        },
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: Center(
            child: ListView(
              children: [
                BlocBuilder<ChangePasswordCubit, ChangePasswordRequested>(
                  builder: (context, state) {
                    return CustomTextField(
                      label: "Current password",
                      placeholder: '',
                      isHidden: true,
                      errorText: state.oldPassword.invalid
                          ? 'Current password must not be empty'
                          : null,
                      onChange: (value) {
                        context
                            .read<ChangePasswordCubit>()
                            .oldPasswordChanged(value);
                      },
                    );
                  },
                ),
                BlocBuilder<ChangePasswordCubit, ChangePasswordRequested>(
                  builder: (context, state) {
                    return CustomTextField(
                      label: "New password",
                      placeholder: '',
                      isHidden: true,
                      errorText: state.newPassword.invalid
                          ? 'New password must not be empty'
                          : null,
                      onChange: (value) {
                        context
                            .read<ChangePasswordCubit>()
                            .newPasswordChanged(value);
                        if (value == confirmPassword) {
                          setState(() {
                            isConfirmed = true;
                          });
                        }
                        if (value != confirmPassword) {
                          setState(() {
                            isConfirmed = false;
                          });
                        }
                      },
                    );
                  },
                ),
                CustomTextField(
                    label: "Confirm password",
                    placeholder: '',
                    isHidden: true,
                    errorText: isConfirmed
                        ? null
                        : 'Confirm password must be the same as new password',
                    onChange: (value) {
                      confirmPassword = value;
                      if (confirmPassword ==
                          context
                              .read<ChangePasswordCubit>()
                              .state
                              .newPassword
                              .value) {
                        setState(() {
                          isConfirmed = true;
                        });
                      }
                      if (confirmPassword !=
                          context
                              .read<ChangePasswordCubit>()
                              .state
                              .newPassword
                              .value) {
                        setState(() {
                          isConfirmed = false;
                        });
                      }
                    }),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocBuilder<ChangePasswordCubit, ChangePasswordRequested>(
                      builder: (context, state) {
                        return RaisedButton(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          onPressed: isConfirmed && state.status.isValidated
                              ? () {
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.confirm,
                                      // text: "Are you sure to change password?",
                                      confirmBtnText: "Yes",
                                      cancelBtnText: "No",
                                      confirmBtnColor:
                                          Theme.of(context).primaryColor,
                                      onConfirmBtnTap: () {
                                        context
                                            .read<ChangePasswordCubit>()
                                            .changePassword(
                                                context
                                                    .read<AuthenticationBloc>()
                                                    .state
                                                    .token,
                                                RepositoryProvider.of<
                                                            AuthenticationRepository>(
                                                        context)
                                                    .username);
                                        Navigator.pop(context);
                                      }).then((value) {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return SimpleDialog(
                                            title: const Text('Submitting...'),
                                            children: [
                                              Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ],
                                          );
                                        });
                                  });
                                }
                              : null,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Change',
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_list_create/violation_create_bloc.dart';
import 'package:capstone_mobile/src/data/repositories/authentication/authentication_repository.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capstone_mobile/src/ui/screens/violation/violation_create_edit_form.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';

class ViolationCreateEditScreen extends StatefulWidget {
  const ViolationCreateEditScreen({
    Key key,
    this.isEditing = false,
    this.violation,
    this.position,
    @required this.onSaveCallBack,
  }) : super(key: key);

  final bool isEditing;
  final Violation violation;
  final int position;
  final Function onSaveCallBack;

  static Route route({
    bool isEditing,
    Violation violation,
    int position,
    @required Function onSaveCallBack,
  }) {
    return MaterialPageRoute<void>(
        settings: RouteSettings(name: "/ViolationCreateEditScreen"),
        builder: (_) => ViolationCreateEditScreen(
              isEditing: isEditing,
              violation: violation,
              position: position,
              onSaveCallBack: onSaveCallBack,
            ));
  }

  @override
  _ViolationCreateEditScreenState createState() =>
      _ViolationCreateEditScreenState();
}

class _ViolationCreateEditScreenState extends State<ViolationCreateEditScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: IconButton(
          iconSize: 16,
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => ViolationCreateBloc(
          violationBloc: BlocProvider.of<ViolationBloc>(context),
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
          violationRepository: ViolationRepository(),
        ),
        child: ViolationCreateEditForm(
          violation: widget.violation,
          size: size,
          onSaveCallBack: widget.onSaveCallBack,
          isEditing: widget.isEditing,
        ),
      ),
    );
  }
}

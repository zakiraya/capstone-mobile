import 'package:capstone_mobile/src/blocs/violation_list_create/violation_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capstone_mobile/src/blocs/blocs.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
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
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Container(
            width: 80,
            child: Center(
              child: Container(
                width: 80,
                height: 28,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Do you want to delete this violation?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              onPressed: () {
                                BlocProvider.of<ViolationBloc>(context)
                                    .add(ViolationDelete(
                                  token: BlocProvider.of<AuthenticationBloc>(
                                          context)
                                      .state
                                      .token,
                                  id: widget.violation.id,
                                ));
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        title: const Text('Submitting...'),
                                        children: [
                                          Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        ],
                                      );
                                    });
                              },
                            ),
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => ViolationCreateBloc(),
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

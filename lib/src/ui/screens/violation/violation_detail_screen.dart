import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_create_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViolationDetailScreen extends StatefulWidget {
  final Violation violation;
  final int id;

  const ViolationDetailScreen({
    Key key,
    @required this.violation,
    @required this.id,
  }) : super(key: key);

  static Route route({
    @required Violation violation,
    @required int id,
  }) {
    return MaterialPageRoute<void>(
        settings: RouteSettings(name: "/ViolationDetailScreen"),
        builder: (_) => ViolationDetailScreen(
              violation: violation,
              id: id,
            ));
  }

  @override
  _ViolationDetailScreenState createState() => _ViolationDetailScreenState();
}

class _ViolationDetailScreenState extends State<ViolationDetailScreen> {
  var updatedViolation;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    // var violation = widget.violation;

    return BlocBuilder<ViolationBloc, ViolationState>(
        builder: (context, state) {
      Violation violation = (state as ViolationLoadSuccess)
          .violations
          .firstWhere((violation) => violation.id == widget.id,
              orElse: () => null);
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
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
          actions: violation.status.toLowerCase() == 'open'
              ? [
                  IconButton(
                    icon: Icon(Icons.edit_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        ViolationCreateEditScreen.route(
                            isEditing: true,
                            violation: violation,
                            onSaveCallBack: (Violation violation) {
                              BlocProvider.of<ViolationBloc>(context).add(
                                ViolationUpdate(
                                  token: BlocProvider.of<AuthenticationBloc>(
                                          context)
                                      .state
                                      .token,
                                  violation: violation,
                                ),
                              );
                            }),
                      ).then((value) => {});
                    },
                    color: Colors.black,
                  )
                ]
              : null,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 16, top: 8, right: 16),
          child: ListView(
            children: [
              Container(
                child: Text(
                  'violation of ${violation.name}',
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: theme.textTheme.headline5.fontSize,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      // child: Text("Created by: ${violation.createdBy}"),
                      ),
                  Container(
                    child: Text(
                      "Status: ${violation.status}",
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text("Branch: "),
                    ),
                    Text(violation.branchName ?? 'empty'),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Text("Regulation: "),
                    ),
                    Text(violation.regulationName ?? 'empty'),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Text("Created on: "),
                    ),
                    Text(violation.createdAt ?? 'empty'),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Text("Description: "),
                    ),
                    Container(
                        width: double.infinity,
                        height: size.height * 0.17,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(violation.description ?? 'empty')),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Text("Evidence: "),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Container(
                        height: size.height * 0.3,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(2),
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: violation.imagePath == null
                                  ? AssetImage('assets/avt.jpg')
                                  : NetworkImage(violation?.imagePath)),
                        ),
                        // child: Hero(
                        //   tag: 'dash',
                        //   child: Image(
                        //     image: NetworkImage(violation.imagePath),
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ImageZoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: 'dash',
        child: Image(
          image: AssetImage('assets/avt.jpg'),
        ),
      ),
    );
  }
}

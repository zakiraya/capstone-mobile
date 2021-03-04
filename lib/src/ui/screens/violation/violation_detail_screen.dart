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
      if (state is ViolationLoadSuccess) {
        Violation violation = state.violations.firstWhere(
            (violation) => violation.id == widget.id,
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
                    Container(
                      width: 80,
                      child: Center(
                        child: Container(
                          width: 80,
                          height: 28,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                ViolationCreateEditScreen.route(
                                    isEditing: true,
                                    violation: violation,
                                    onSaveCallBack: (Violation violation) {
                                      BlocProvider.of<ViolationBloc>(context)
                                          .add(
                                        ViolationUpdate(
                                          token: BlocProvider.of<
                                                  AuthenticationBloc>(context)
                                              .state
                                              .token,
                                          violation: violation,
                                        ),
                                      );
                                    }),
                              );
                            },
                            child: Text('Edit', style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffFFBB33),
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
                  ]
                : null,
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 16, top: 8, right: 16),
            child: ListView(
              children: [
                Container(
                  child: Text(
                    'Violation of ${violation.name}',
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontSize: theme.textTheme.headline5.fontSize,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text("Status: "),
                    ),
                    Container(
                      child: Text(
                        "${violation.status}",
                        style: TextStyle(color: Colors.green),
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
                        child: Text("Branch: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Text(violation.branchName ?? 'empty'),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Text("Regulation: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Text(violation.regulationName ?? 'empty'),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Text("Created on: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        violation.createdAt ?? 'empty',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Text("Description: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          // minHeight: size.height * 0.17,
                          minWidth: double.infinity,
                        ),
                        child: Container(
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     width: 1,
                            //   ),
                            //   borderRadius: BorderRadius.circular(2),
                            // ),
                            child: Text(violation.description ?? 'empty')),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Text("Evidence: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Image(
                        image: violation.imagePath == null
                            ? AssetImage('assets/avt.jpg')
                            : NetworkImage(violation?.imagePath),
                      ),
                      // Center(
                      //   child: Container(
                      //     height: size.height * 0.3,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //         width: 1,
                      //       ),
                      //       borderRadius: BorderRadius.circular(2),
                      //       image: DecorationImage(
                      //           fit: BoxFit.contain,
                      //           image: violation.imagePath == null
                      //               ? AssetImage('assets/avt.jpg')
                      //               : NetworkImage(violation?.imagePath)),
                      //     ),
                      //     // child: Hero(
                      //     //   tag: 'dash',
                      //     //   child: Image(
                      //     //     image: NetworkImage(violation.imagePath),
                      //     //   ),
                      //     // ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return Container(child: Text('Violation list'));
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

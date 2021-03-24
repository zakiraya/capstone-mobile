import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_repository.dart';
import 'package:capstone_mobile/src/ui/constants/constant.dart';
import 'package:capstone_mobile/src/ui/utils/skeleton_loading.dart';
import 'package:capstone_mobile/src/ui/widgets/violation/action_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone_mobile/generated/l10n.dart';
import 'package:capstone_mobile/src/blocs/localization/localization_bloc.dart';
import 'package:intl/intl.dart';

enum ExtraAction { remove, edit }

class ViolationDetailByIdScreen extends StatefulWidget {
  final int id;

  const ViolationDetailByIdScreen({
    Key key,
    @required this.id,
  }) : super(key: key);

  static Route route({
    @required int id,
  }) {
    return MaterialPageRoute<void>(
        settings:
            RouteSettings(name: "/ViolationDetailByIdScreen", arguments: int),
        builder: (_) => ViolationDetailByIdScreen(
              id: id,
            ));
  }

  @override
  _ViolationDetailByIdScreenState createState() =>
      _ViolationDetailByIdScreenState();
}

class _ViolationDetailByIdScreenState extends State<ViolationDetailByIdScreen> {
  final ViolationRepository _violationRepository = ViolationRepository();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<LocalizationBloc, String>(builder: (context, state) {
      return FutureBuilder(
          future: _violationRepository.fetchViolations(
            token: BlocProvider.of<AuthenticationBloc>(context).state.token,
            id: widget.id,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              if (snapshot.data.length != 0) {
                Violation violation = snapshot.data[0];
                return Scaffold(
                  appBar: AppBar(
                    elevation: 0,
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
                    title: Transform(
                      transform: Matrix4.translationValues(-37.0, 1, 0.0),
                      child: Text(
                        S.of(context).BACK,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    actions: violation?.status?.toLowerCase() == 'opening'
                        ? BlocProvider.of<AuthenticationBloc>(context)
                                    .state
                                    .user
                                    .roleName ==
                                Constant.ROLE_QC
                            ? [
                                ActionPopupMenu(
                                  theme: theme,
                                  violation: violation,
                                  widget: widget,
                                  successCallBack: (context) {
                                    Navigator.pop(context);
                                    Navigator.pop(context, violation.id);
                                  },
                                ),
                              ]
                            : [
                                ActionPopupMenuForBM(
                                  theme: theme,
                                  violation: violation,
                                  widget: widget,
                                  successCallBack: (context) {
                                    Navigator.pop(context);
                                    Navigator.pop(context, violation.id);
                                  },
                                ),
                              ]
                        : null,
                  ),
                  body: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: ListView(
                      children: [
                        Container(
                          child: Text(
                            S.of(context).VIOLATION +
                                ' ' +
                                S.of(context).OF +
                                ' ' +
                                '${violation?.regulationName}',
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child:
                                  Text(S.of(context).VIOLATION_STATUS + ': '),
                            ),
                            Container(
                              child: Text(
                                "${violation?.status}",
                                style: TextStyle(
                                    color: Constant.violationStatusColors[
                                        violation?.status]),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                            color: Constant
                                .violationStatusColors[violation?.status]),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  S.of(context).BRANCH + ":",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(violation?.branchName ?? ''),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                child: Text(
                                  S.of(context).CREATED_ON + ':',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd(
                                            BlocProvider.of<LocalizationBloc>(
                                                    context)
                                                .state)
                                        .format(violation?.createdAt) ??
                                    '',
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                child: Text(S.of(context).DESCRIPTION + ':',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: double.infinity,
                                ),
                                child: Container(
                                    child: Text(violation?.description ?? '')),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                child: Text(S.of(context).EVIDENCE + ':',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: violation.imagePaths.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Text(' - ' +
                                              S.of(context).EVIDENCE +
                                              ' ${index + 1} ')),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Center(
                                        child: Image(
                                          image: NetworkImage(
                                            violation.imagePaths[index],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
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
                  title: Transform(
                    transform: Matrix4.translationValues(-37.0, 1, 0.0),
                    child: Text(
                      S.of(context).BACK,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                body: Center(
                  child: Text(S.of(context).LOAD_FAIL),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
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
                  title: Transform(
                    transform: Matrix4.translationValues(-37.0, 1, 0.0),
                    child: Text(
                      S.of(context).BACK,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                body: Center(
                    child: SkeletonLoading(
                  item: 2,
                )),
              );
            }
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
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
                title: Transform(
                  transform: Matrix4.translationValues(-37.0, 1, 0.0),
                  child: Text(
                    S.of(context).BACK,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
              body: Center(
                child: Text(
                  snapshot.connectionState.toString(),
                ),
              ),
            );
          });
    });
  }
}

// class ActionPopupMenu extends StatelessWidget {
//   const ActionPopupMenu({
//     Key key,
//     @required this.theme,
//     @required this.violation,
//     @required this.widget,
//   }) : super(key: key);

//   final ThemeData theme;
//   final Violation violation;
//   final ViolationDetailByIdScreen widget;

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       icon: Icon(
//         Icons.more_horiz,
//         color: theme.primaryColor,
//       ),
//       onSelected: (action) {
//         switch (action) {
//           case ExtraAction.edit:
//             Navigator.push(
//               context,
//               ViolationCreateEditScreen.route(
//                   isEditing: true,
//                   violation: violation.copyWith(),
//                   destinationScreen: 'Home',
//                   onSaveCallBack: (Violation vio) {}),
//             );
//             break;
//           case ExtraAction.remove:
//             showDialog<void>(
//               context: context,
//               barrierDismissible: false, // user must tap button!
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text(S.of(context).POPUP_DELETE_VIOLATION),
//                   actions: <Widget>[
//                     TextButton(
//                       child: Text(
//                         S.of(context).DELETE,
//                         style: TextStyle(
//                           color: Colors.red,
//                         ),
//                       ),
//                       onPressed: () {
//                         BlocProvider.of<ViolationBloc>(context)
//                             .add(ViolationDelete(
//                           token: BlocProvider.of<AuthenticationBloc>(context)
//                               .state
//                               .token,
//                           id: violation.id,
//                         ));
//                         CoolAlert.show(
//                           barrierDismissible: false,
//                           context: context,
//                           type: CoolAlertType.loading,
//                           text: S.of(context).POPUP_CREATE_VIOLATION_SUBMITTING,
//                         );
//                       },
//                     ),
//                     TextButton(
//                       child: Text(S.of(context).CANCEL),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//             break;
//         }
//       },
//       itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
//         PopupMenuItem<ExtraAction>(
//           value: ExtraAction.edit,
//           child: Text(S.of(context).EDIT),
//         ),
//         PopupMenuItem<ExtraAction>(
//           value: ExtraAction.remove,
//           child: Text(S.of(context).DELETE),
//         ),
//       ],
//     );
//   }
// }

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

import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/blocs/report_delete/report_delete_cubit.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/data/repositories/branch/branch_repository.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_repository.dart';
import 'package:capstone_mobile/src/ui/screens/report/report_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportDetailScreen extends StatefulWidget {
  const ReportDetailScreen({
    Key key,
    @required this.report,
    this.isEditable = false,
  }) : super(key: key);

  static Route route({@required Report report, bool isEditable}) {
    return MaterialPageRoute<void>(
        builder: (_) => ReportDetailScreen(
              report: report,
              isEditable: isEditable,
            ));
  }

  final Report report;
  final bool isEditable;

  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    var report = widget.report;
    TextEditingController descriptionTextFieldController =
        TextEditingController(text: report.description);

    return BlocProvider(
      create: (context) => ReportCreateBloc(
        branchRepository: BranchRepository(),
        reportRepository: ReportRepository(),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
          // title: Text('Report detail'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          actions: widget.isEditable == true
              ? [
                  Builder(builder: (context) {
                    return IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        color: theme.primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          isEditing = true;
                        });

                        context.read<ReportCreateBloc>().add(
                              ReportEditing(
                                report: report,
                              ),
                            );
                      },
                    );
                  }),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline_outlined,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider(
                          create: (context) => ReportDeleteCubit(
                              reportRepository: ReportRepository()),
                          child: BlocConsumer<ReportDeleteCubit,
                              ReportDeleteState>(
                            listener: (context, state) {
                              if (state is ReportDeleteSuccess) {
                                Navigator.of(context).pop();
                              }
                            },
                            builder: (context, state) {
                              if (state is ReportDeleteInitial) {
                                return AlertDialog(
                                  title: Text('Accept?'),
                                  content: Text(
                                      'Do you accept to delete this report?'),
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('No'),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        context
                                            .read<ReportDeleteCubit>()
                                            .deleteReport('token', report.id);
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                );
                              } else if (state is ReportDeleteInProgress) {
                                return SimpleDialog(
                                  title: const Text('Deleting...'),
                                  children: [
                                    Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  ],
                                );
                              } else {
                                return AlertDialog(
                                  title: Text("Error"),
                                  // content: Text("This is my message."),
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Back'),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ]
              : [],
        ),
        body: ReportEditForm(
          report: report,
          theme: theme,
          descriptionTextFieldController: descriptionTextFieldController,
          isEditing: isEditing,
          size: size,
        ),
      ),
    );
  }
}

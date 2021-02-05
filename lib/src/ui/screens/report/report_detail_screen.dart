import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/repositories/branch/branch_repository.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_repository.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_repository.dart';
import 'package:capstone_mobile/src/ui/screens/report/report_edit_form.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_card.dart';
import 'package:capstone_mobile/src/ui/utils/skeleton_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportDetailScreen extends StatefulWidget {
  const ReportDetailScreen({Key key, @required this.report}) : super(key: key);

  static Route route({@required Report report}) {
    return MaterialPageRoute<void>(
        builder: (_) => ReportDetailScreen(
              report: report,
            ));
  }

  final Report report;

  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  bool editable = false;

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
          actions: [
            Builder(builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.edit,
                  color: theme.primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    editable = true;
                  });

                  context.read<ReportCreateBloc>().add(
                        ReportEditing(
                          report: report,
                        ),
                      );
                },
              );
            })
          ],
        ),
        body: ReportEditForm(
            report: report,
            theme: theme,
            descriptionTextFieldController: descriptionTextFieldController,
            editable: editable,
            size: size),
      ),
    );
  }
}

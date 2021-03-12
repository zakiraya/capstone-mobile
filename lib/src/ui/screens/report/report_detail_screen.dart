import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/blocs/localization/localization_bloc.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/data/repositories/authentication/authentication_repository.dart';
import 'package:capstone_mobile/src/data/repositories/branch/branch_repository.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_repository.dart';
import 'package:capstone_mobile/src/ui/screens/report/report_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportDetailScreen extends StatelessWidget {
  final Report report;

  const ReportDetailScreen({Key key, this.report}) : super(key: key);

  static Route route({@required Report report}) {
    return MaterialPageRoute<void>(
        builder: (_) => ReportDetailScreen(
              report: report,
            ));
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    TextEditingController descriptionTextFieldController =
        TextEditingController(text: report.description);

    return BlocProvider(
        create: (context) => ReportCreateBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
              branchRepository: BranchRepository(),
              reportRepository: ReportRepository(),
            ),
        child: BlocBuilder<LocalizationBloc, String>(
          builder: (context, state) {
            // if (report.status.toLowerCase() == 'opening') {
            //     BlocProvider.of<ReportCreateBloc>(context).add(
            //       ReportEditing(
            //         report: report,
            //       ),
            //     );
            //   }

            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: theme.scaffoldBackgroundColor,
                // title: Text('Report detail'),
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

                actions: report.status.toLowerCase() == 'opening'
                    ? [
                        Builder(builder: (context) {
                          return IconButton(
                            icon: Icon(
                              Icons.edit_outlined,
                              color: theme.primaryColor,
                            ),
                            onPressed: () {},
                          );
                        }),
                      ]
                    : [],
              ),
              body: ReportEditForm(
                report: report,
                descriptionTextFieldController: descriptionTextFieldController,
                isEditing: report.status.toLowerCase() == 'opening',
                size: size,
              ),
            );
          },
        ));
  }
}

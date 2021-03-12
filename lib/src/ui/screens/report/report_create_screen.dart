import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/data/repositories/authentication/authentication_repository.dart';
import 'package:capstone_mobile/src/data/repositories/branch/branch_repository.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_repository.dart';
import 'package:capstone_mobile/src/ui/screens/report/report_create_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateReportScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CreateReportScreen());
  }

  @override
  _CreateReportScreenState createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
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
        create: (context) => ReportCreateBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
          reportRepository: ReportRepository(),
          branchRepository: BranchRepository(),
        ),
        child: ReportForm(),
      ),
    );
  }
}

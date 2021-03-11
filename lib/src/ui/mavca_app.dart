import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/blocs/branch/branch_bloc.dart';
import 'package:capstone_mobile/src/blocs/notification/notification_bloc.dart';
import 'package:capstone_mobile/src/blocs/regulation/regulation_bloc.dart';
import 'package:capstone_mobile/src/blocs/report/report_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/data/repositories/branch/branch_repository.dart';
import 'package:capstone_mobile/src/data/repositories/notification/notification_repository.dart';
import 'package:capstone_mobile/src/data/repositories/regulation/regulation_repository.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_repository.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_repository.dart';
import 'package:capstone_mobile/src/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MavcaApp extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      settings: RouteSettings(name: "/Mavca"),
      builder: (_) => MavcaApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      // BlocProvider(
      //     create: (context) => ViolationBloc(
      //           violationRepository: ViolationRepository(),
      //         )..add(ViolationRequested(
      //             token:
      //                 BlocProvider.of<AuthenticationBloc>(context).state.token,
      //           ))),
      BlocProvider(
          create: (context) => ReportBloc(reportRepository: ReportRepository())
            ..add(ReportRequested(
              token: BlocProvider.of<AuthenticationBloc>(context).state.token,
            ))),
      BlocProvider(
        create: (context) =>
            NotificationBloc(notificationRepository: NotificationRepository())
              ..add(NotificationRequested(
                token: BlocProvider.of<AuthenticationBloc>(context).state.token,
              )),
      ),
      BlocProvider(
        create: (context) => BranchBloc(branchRepository: BranchRepository())
          ..add(BranchRequested(
            token: BlocProvider.of<AuthenticationBloc>(context).state.token,
          )),
      ),
      BlocProvider(
        create: (context) =>
            RegulationBloc(regulationRepository: RegulationRepository())
              ..add(RegulationRequested(
                token: BlocProvider.of<AuthenticationBloc>(context).state.token,
              )),
      )
    ], child: HomeScreen());
  }
}

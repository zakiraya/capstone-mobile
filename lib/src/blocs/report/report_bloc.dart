import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository reportRepository;

  ReportBloc({@required this.reportRepository}) : super(ReportInitial());

  @override
  Stream<ReportState> mapEventToState(
    ReportEvent event,
  ) async* {
    if (event is ReportRequested) {
      yield ReportLoadInProgress();
      try {
        final List<Report> reports = await reportRepository.fetchReports(
          token: event.token,
          status: event.status,
        );
        yield ReportLoadSuccess(reports: reports);
      } catch (e) {
        print(e);
        yield ReportLoadFailure();
      }
    }
  }
}

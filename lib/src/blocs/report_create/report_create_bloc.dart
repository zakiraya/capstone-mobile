import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/data/models/report/report_description.dart';
import 'package:capstone_mobile/src/data/models/report/report_name.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

part 'report_create_event.dart';
part 'report_create_state.dart';

class ReportCreateBloc extends Bloc<ReportCreateEvent, ReportCreateState> {
  ReportCreateBloc({@required this.reportRepository})
      : super(ReportCreateState());

  final ReportRepository reportRepository;

  @override
  Stream<ReportCreateState> mapEventToState(
    ReportCreateEvent event,
  ) async* {
    if (event is ReportNameChanged) {
      yield _mapReportNameChangeToState(event, state);
    } else if (event is ReportDescriptionChanged) {
      yield _mapReportDesriptionChangeToState(event, state);
    } else if (event is ReportCreateSubmitted) {
      yield* _mapReportCreateSubmittedToState(event, state);
    }
  }

  ReportCreateState _mapReportNameChangeToState(
      ReportNameChanged event, ReportCreateState state) {
    final reportName = ReportName.dirty(event.reportName);
    return state.copyWith(
        reportName: reportName,
        status: Formz.validate([reportName, state.reportDescription]));
  }

  ReportCreateState _mapReportDesriptionChangeToState(
      ReportDescriptionChanged event, ReportCreateState state) {
    final reportDescription = ReportDescription.dirty(event.reportDescription);
    return state.copyWith(
      reportDescription: reportDescription,
      status: Formz.validate([reportDescription, state.reportName]),
    );
  }

  Stream<ReportCreateState> _mapReportCreateSubmittedToState(
      ReportCreateSubmitted event, ReportCreateState state) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        print(state.reportName.value);
        print(state.reportDescription.value);
        var result = await reportRepository.createReport(
            token: "token",
            report: Report(
                name: state.reportName.value,
                description: state.reportDescription.value),
            isDraft: event.isDraft);

        print("result: $result");
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } catch (e) {
        print(e);
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}

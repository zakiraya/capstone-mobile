import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/data/models/report/report_branch.dart';
import 'package:capstone_mobile/src/data/models/report/report_description.dart';
import 'package:capstone_mobile/src/data/models/report/report_list_violation.dart';
import 'package:capstone_mobile/src/data/models/report/report_name.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/repositories/branch/branch_repository.dart';
import 'package:capstone_mobile/src/data/repositories/report/report_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

part 'report_create_event.dart';
part 'report_create_state.dart';

class ReportCreateBloc extends Bloc<ReportCreateEvent, ReportCreateState> {
  ReportCreateBloc(
      {@required this.branchRepository, @required this.reportRepository})
      : super(ReportCreateState());

  final ReportRepository reportRepository;
  final BranchRepository branchRepository;

  @override
  Stream<ReportCreateState> mapEventToState(
    ReportCreateEvent event,
  ) async* {
    if (event is ReportNameChanged) {
      yield _mapReportNameChangeToState(event, state);
    } else if (event is ReportDescriptionChanged) {
      yield _mapReportDesriptionChangeToState(event, state);
    } else if (event is ReportBranchChanged) {
      yield _mapReportBranchChangetoState(event, state);
    } else if (event is ReportViolationsChanged) {
      yield _mapReportViolationListChangeToState(event, state);
    } else if (event is ReportCreateSubmitted) {
      yield* _mapReportCreateSubmittedToState(event, state);
    }
  }

  ReportCreateState _mapReportNameChangeToState(
      ReportNameChanged event, ReportCreateState state) {
    final reportName = ReportName.dirty(event.reportName);
    return state.copyWith(
        reportName: reportName,
        status: Formz.validate(
            [reportName, state.reportDescription, state.reportBranch]));
  }

  ReportCreateState _mapReportBranchChangetoState(
      ReportBranchChanged event, ReportCreateState state) {
    final reportBranch = ReportBranch.dirty(event.reportBranchId);
    // state.props.remove(state?.reportBranch);
    return state.copyWith(
      reportBranch: reportBranch,
      status: Formz.validate([
        state.reportDescription,
        state.reportListViolation,
        reportBranch,
      ]),
    );
  }

  ReportCreateState _mapReportDesriptionChangeToState(
      ReportDescriptionChanged event, ReportCreateState state) {
    final reportDescription = ReportDescription.dirty(event.reportDescription);
    return state.copyWith(
      reportDescription: reportDescription,
      status: Formz.validate(
        [
          reportDescription,
          state.reportListViolation,
          state.reportBranch,
        ],
      ),
    );
  }

  ReportCreateState _mapReportViolationListChangeToState(
      ReportViolationsChanged event, ReportCreateState state) {
    List<Violation> list = state.reportListViolation.value
        ?.map((violation) => violation)
        ?.toList();

    if (list == null) {
      list = List();
    }

    list.add(event.reportViolation);

    final reportViolations = ReportListViolation.dirty(list);
    print('new list: ${list.length}');
    return state.copyWith(
      reportListViolation: reportViolations,
      status: Formz.validate([
        reportViolations,
        state.reportDescription,
        state.reportBranch,
      ]),
    );
  }

  ReportCreateState _mapReportViolationRemoveToState(
      ReportViolationRemove event, ReportCreateState state) {}

  Stream<ReportCreateState> _mapReportCreateSubmittedToState(
      ReportCreateSubmitted event, ReportCreateState state) async* {
    if (state.status.isValidated || event.isDraft) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        DateTime date = DateTime.now();
        var result = await reportRepository.createReport(
            token:
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InFjIiwicm9sZUlkIjoiNiIsInJvbGVOYW1lIjoiUUMgTWFuYWdlciIsImp0aSI6IjAyNDNjMTQxLWYwMWEtNDY3Ny05NWM0LTE2NjE5Y2EzNzA4ZSIsIm5iZiI6MTYxMjA2ODMyNCwiZXhwIjoxNjEyMDY4NjI0LCJpYXQiOjE2MTIwNjgzMjQsImF1ZCI6Ik1hdmNhIn0.dK4_IdMsgrfvzc_8TnN5hPOXhFdfqOOh08gSFcb5WiI",
            report: Report(
              name: reportNameGenerate(state.reportBranch.value, date, 1),
              branchId: state.reportBranch.value,
              description: state.reportDescription.value,
              createdBy: 11,
            ),
            isDraft: event.isDraft);
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } catch (e) {
        print(e);
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}

String reportNameGenerate(int branchId, DateTime createdDate, int employeeId) {
  return branchId.toString() +
      '-' +
      createdDate.day.toString().padLeft(2, '0') +
      createdDate.month.toString().padLeft(2, '0') +
      createdDate.year.toString() +
      '-' +
      employeeId.toString();
}

String formatDate(DateTime date) {
  return date.day.toString().padLeft(2, '0') +
      '-' +
      date.month.toString().padLeft(2, '0') +
      '-' +
      date.year.toString();
}

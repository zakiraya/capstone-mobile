import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_filter/filter.dart';
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
      yield* _mapReportRequestedToState(event);
    } else if (event is FilterChanged) {
      yield* _mapFilterChangedToState(event);
    }
  }

  Stream<ReportState> _mapReportRequestedToState(
    ReportRequested event,
  ) async* {
    final currentState = state;
    try {
      if (currentState is ReportInitial || currentState is ReportLoadFailure) {
        final List<Report> reports = await reportRepository.fetchReports(
          token: event.token,
          sort: 'desc id',
          page: 0,
        );

        yield ReportLoadSuccess(
          reports: reports,
          hasReachedMax: reports.length < 20 ? true : false,
          activeFilter: Filter(),
        );
        return;
      }

      if (currentState is ReportLoadSuccess && event.isRefresh == true) {
        final List<Report> reports = await reportRepository.fetchReports(
          token: event.token,
          sort: 'desc id',
          page: 0,
          branchId: currentState.activeFilter?.branchId,
          status: currentState.activeFilter?.status,
        );

        yield currentState.copyWith(
          reports: reports,
        );
        return;
      }

      if (currentState is ReportLoadSuccess && !_hasReachedMax(currentState)) {
        final List<Report> reports = await reportRepository.fetchReports(
          token: event.token,
          sort: 'desc id',
          page: currentState.reports.length / 20,
          branchId: currentState.activeFilter?.branchId,
          status: currentState.activeFilter?.status,
        );
        yield reports.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : currentState.copyWith(
                reports: currentState.reports + reports,
                hasReachedMax: false,
              );
        return;
      }
    } catch (e) {
      print(' _mapReportRequestedToState: ');
      print(e);
      yield ReportLoadFailure();
    }
  }

  Stream<ReportState> _mapFilterChangedToState(FilterChanged event) async* {
    final currentState = state;
    try {
      if (currentState is ReportLoadSuccess) {
        final List<Report> reports = await reportRepository.fetchReports(
          token: event.token,
          sort: 'desc id',
          page: 0,
          branchId: event.filter?.branchId,
          status: event.filter?.status,
        );

        yield currentState.copyWith(
          hasReachedMax: reports.length < 20 ? true : false,
          reports: reports,
          activeFilter: event.filter,
        );
      }
    } catch (e) {
      print(' _mapFilterChangeToState: ');
      print(e);
    }
  }

  bool _hasReachedMax(ReportState state) =>
      state is ReportLoadSuccess && state.hasReachedMax;
}

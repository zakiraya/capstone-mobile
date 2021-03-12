import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_mobile/src/blocs/report/report_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_filter/filter.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'report_filter_event.dart';
part 'report_filter_state.dart';

class ReportFilterBloc extends Bloc<ReportFilterEvent, ReportFilterState> {
  final ReportBloc reportBloc;

  ReportFilterBloc({@required this.reportBloc})
      : super(ReportFilterState(
          filter: (reportBloc.state as ReportLoadSuccess).activeFilter,
        ));

  @override
  Stream<ReportFilterState> mapEventToState(
    ReportFilterEvent event,
  ) async* {
    if (event is ReportFilterBranchIdUpdated) {
      reportBloc.add(FilterChanged(
        filter: Filter(
          branchId: event.branchId,
          status: state.filter.status,
          regulationId: state.filter.regulationId,
          month: state.filter.month,
        ),
      ));
      yield state.copyWith(
        filter: Filter(
          branchId: event.branchId,
          status: state.filter.status,
          regulationId: state.filter.regulationId,
          month: state.filter.month,
        ),
      );
    } else if (event is ReportFilterRegulationUpdated) {
      reportBloc.add(FilterChanged(
        filter: Filter(
          branchId: state.filter.branchId,
          status: state.filter.status,
          regulationId: event.regulationId,
          month: state.filter.month,
        ),
      ));
      yield state.copyWith(
        filter: Filter(
          branchId: state.filter.branchId,
          status: state.filter.status,
          regulationId: event.regulationId,
          month: state.filter.month,
        ),
      );
    } else if (event is ReportFilterStatusUpdated) {
      reportBloc.add(FilterChanged(
        filter: Filter(
          branchId: state.filter.branchId,
          status: event.status,
          regulationId: state.filter.regulationId,
          month: state.filter.month,
        ),
      ));
      yield state.copyWith(
        filter: Filter(
          branchId: state.filter.branchId,
          status: event.status,
          regulationId: state.filter.regulationId,
          month: state.filter.month,
        ),
      );
    } else if (event is ReportFilterMonthUpdated) {
      reportBloc.add(FilterChanged(
        filter: Filter(
          branchId: state.filter.branchId,
          status: state.filter.status,
          regulationId: state.filter.regulationId,
          month: event.month,
        ),
      ));
      yield state.copyWith(
        filter: Filter(
          branchId: state.filter.branchId,
          status: state.filter.status,
          regulationId: state.filter.regulationId,
          month: event.month,
        ),
      );
    }
    // TODO: implement mapEventToState
  }
}

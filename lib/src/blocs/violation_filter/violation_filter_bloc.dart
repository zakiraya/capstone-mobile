import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_filter/filter.dart';
import '../violation/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';

part 'violation_filter_event.dart';
part 'violation_filter_state.dart';

class ViolationFilterBloc
    extends Bloc<ViolationFilterEvent, ViolationFilterState> {
  ViolationFilterBloc() : super(ViolationFilterState(filter: Filter()));

  @override
  Stream<ViolationFilterState> mapEventToState(
    ViolationFilterEvent event,
  ) async* {
    if (event is ViolationFilterBranchIdUpdated) {
      yield state.copyWith(
        filter: Filter(
          branchId: event.branchId,
          status: state.filter.status,
          regulationId: state.filter.regulationId,
        ),
      );
    } else if (event is ViolationFilterRegulationUpdated) {
      yield state.copyWith(
        filter: Filter(
          branchId: state.filter.branchId,
          status: state.filter.status,
          regulationId: event.regulationId,
        ),
      );
    } else if (event is ViolationFilterStatusUpdated) {
      yield state.copyWith(
        filter: Filter(
          branchId: state.filter.branchId,
          status: event.status,
          regulationId: state.filter.regulationId,
        ),
      );
    }
  }
}

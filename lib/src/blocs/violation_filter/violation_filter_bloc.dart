import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';

part 'violation_filter_event.dart';
part 'violation_filter_state.dart';

class ViolationFilterBloc
    extends Bloc<ViolationFilterEvent, ViolationFilterState> {
  final ViolationBloc violationBloc;
  StreamSubscription violationSubscription;

  ViolationFilterBloc({@required this.violationBloc})
      : super(
          violationBloc.state is ViolationLoadSuccess
              ? ViolationFilterSucess(
                  (violationBloc.state as ViolationLoadSuccess).violations,
                  '',
                )
              : ViolationFilterInProgress(),
        ) {
    violationSubscription = violationBloc.listen((state) {
      if (state is ViolationLoadSuccess) {
        add(ViolationsUpdated(
            (violationBloc.state as ViolationLoadSuccess).violations));
      }
    });
  }

  @override
  Stream<ViolationFilterState> mapEventToState(
    ViolationFilterEvent event,
  ) async* {
    if (event is FilterUpdated) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is ViolationsUpdated) {
      yield* _mapViolationsUpdatedToState(event);
    }
  }

  Stream<ViolationFilterState> _mapUpdateFilterToState(
    FilterUpdated event,
  ) async* {
    if (violationBloc.state is ViolationLoadSuccess) {
      yield ViolationFilterSucess(
        _mapViolationsToFilteredViolation(
          (violationBloc.state as ViolationLoadSuccess).violations,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<ViolationFilterState> _mapViolationsUpdatedToState(
    ViolationsUpdated event,
  ) async* {
    final visibilityFilter = state is ViolationFilterSucess
        ? (state as ViolationFilterSucess).activeFilter
        : '';
    yield ViolationFilterSucess(
      _mapViolationsToFilteredViolation(
        (violationBloc.state as ViolationLoadSuccess).violations,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Violation> _mapViolationsToFilteredViolation(
      List<Violation> violations, String filter) {
    return violations.where((violation) {
      if (filter == '') {
        return true;
      } else {
        return violation.branchName == filter;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    violationSubscription.cancel();
    return super.close();
  }
}

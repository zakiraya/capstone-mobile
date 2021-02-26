import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_repository.dart';
import 'package:equatable/equatable.dart';

part 'violation_event.dart';
part 'violation_state.dart';

class ViolationBloc extends Bloc<ViolationEvent, ViolationState> {
  ViolationBloc({@required this.violationRepository})
      : super(ViolationInitial());

  final ViolationRepository violationRepository;

  @override
  Stream<Transition<ViolationEvent, ViolationState>> transformEvents(
    Stream<ViolationEvent> events,
    TransitionFunction<ViolationEvent, ViolationState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ViolationState> mapEventToState(
    ViolationEvent event,
  ) async* {
    final currentState = state;
    if (event is ViolationRequested && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ViolationInitial || event.isRefresh == true) {
          final List<Violation> violations =
              await violationRepository.fetchViolations(
            token: event.token,
            sort: 'desc id',
            page: 0,
          );

          yield ViolationLoadSuccess(
              violations: violations, hasReachedMax: false);
          return;
        }

        if (currentState is ViolationLoadSuccess) {
          final List<Violation> violations =
              await violationRepository.fetchViolations(
            token: event.token,
            sort: 'desc id',
            page: currentState.violations.length / 20,
          );

          yield violations.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ViolationLoadSuccess(
                  violations: currentState.violations + violations,
                  hasReachedMax: false,
                );
        }
      } catch (e) {
        print(e);
        yield ViolationLoadFailure();
      }
    } else if (event is ViolationUpdate) {
      yield* _mapViolationUpdateToState(event);
    } else if (event is ViolationDelete) {
      yield* _mapViolationDeleteToState(event);
    }
  }

  Stream<ViolationState> _mapViolationUpdateToState(
      ViolationUpdate event) async* {
    final currentState = state;
    try {
      if (currentState is ViolationLoadSuccess) {
        await violationRepository.editViolation(
          token: event.token,
          violation: event.violation,
        );

        final List<Violation> updatedViolations =
            await violationRepository.fetchViolations(
          token: event.token,
          sort: 'desc id',
          limit: currentState.violations.length,
        );

        yield currentState.copyWith(
          violations: updatedViolations,
          screen: '/ViolationDetailScreen',
        );
      }
    } catch (e) {
      print(' _mapViolationUpdateToState');
      print(e);
    }
  }

  Stream<ViolationState> _mapViolationDeleteToState(
      ViolationDelete event) async* {
    final currentState = state;
    try {
      if (currentState is ViolationLoadSuccess) {
        // final updatedViolations = (state as ViolationLoadSuccess)
        //     .violations
        //     .where((violation) => violation.id != event.id)
        //     .toList();

        await violationRepository.deleteViolation(
          token: event.token,
          id: event.id,
        );
        final List<Violation> updatedViolations =
            await violationRepository.fetchViolations(
          token: event.token,
          sort: 'desc id',
          limit: currentState.violations.length,
        );
        yield (state as ViolationLoadSuccess).copyWith(
          violations: updatedViolations,
          screen: '/Home',
        );
      }
    } catch (e) {
      print(' _mapViolationDeleteToState');
      print(e);
    }
  }

  bool _hasReachedMax(ViolationState state) =>
      state is ViolationLoadSuccess && state.hasReachedMax;
}

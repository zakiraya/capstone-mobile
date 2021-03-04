import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';

import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_repository.dart';

part 'violation_list_state.dart';
part 'violation_list_event.dart';

class ViolationListCubit extends Cubit<ViolationListState> {
  ViolationListCubit({@required this.violationRepository})
      : super(ViolationListState(violations: List<Violation>()));

  final ViolationRepository violationRepository;

  Future<void> submitViolationList(List<Violation> list, String token) async {
    try {
      emit(ViolationListState(
        violations: list,
        status: FormzStatus.submissionInProgress,
      ));
      final result =
          violationRepository.createViolation(token: token, violations: list);
      emit(ViolationListState(
        status: FormzStatus.submissionSuccess,
        violations: list,
      ));
    } catch (e) {
      print(e);
      emit(ViolationListState(status: FormzStatus.submissionFailure));
    }
  }
}

class ViolationListBloc extends Bloc<ViolationListEvent, ViolationListState> {
  final ViolationRepository violationRepository;

  ViolationListBloc({@required this.violationRepository})
      : super(ViolationListState(violations: List<Violation>()));

  @override
  Stream<ViolationListState> mapEventToState(
    ViolationListEvent event,
  ) async* {
    if (event is ViolationListChanged) {
      yield _mapViolationListChangeToState(event, state);
    } else if (event is ViolationListRemove) {
      yield _mapViolationListRemoveToState(event, state);
    } else if (event is ViolationItemUpdate) {
      yield _mapViolationUpdateToState(event, state);
    } else if (event is ViolationListSubmitted) {
      yield* _mapViolationListSubmittedToState(event, state);
    }
  }

  ViolationListState _mapViolationListChangeToState(
    ViolationListChanged event,
    ViolationListState state,
  ) {
    final violation = event.violation;
    List<Violation> violations =
        state.violations.map((violation) => violation).toList();

    violations.add(violation);
    return state.copyWith(
      violations: violations,
      status: FormzStatus.valid,
    );
  }

  ViolationListState _mapViolationUpdateToState(
    ViolationItemUpdate event,
    ViolationListState state,
  ) {
    List<Violation> violations =
        state.violations.map((violation) => violation).toList();

    violations[event.position] = event.violation;

    return state.copyWith(
      violations: violations,
      status: FormzStatus.valid,
    );
  }

  ViolationListState _mapViolationListRemoveToState(
    ViolationListRemove event,
    ViolationListState state,
  ) {
    if (state.violations.length < 1) {
      return state.copyWith(
        status: FormzStatus.invalid,
      );
    }

    List<Violation> violations =
        state.violations.map((violation) => violation).toList();

    violations.removeAt(event.position);

    return state.copyWith(
      violations: violations,
      status: violations.length > 0 ? FormzStatus.valid : FormzStatus.invalid,
    );
  }

  Stream<ViolationListState> _mapViolationListSubmittedToState(
    ViolationListSubmitted event,
    ViolationListState state,
  ) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      var result = await violationRepository.createViolation(
        token: event.token,
        violations: state.violations,
      );
      yield state.copyWith(
        // violations: List<Violation>(),
        status: FormzStatus.submissionSuccess,
      );
      yield state.copyWith(
        violations: List<Violation>(),
        status: FormzStatus.invalid,
      );
    } catch (e) {
      print('violation_list_bloc: ');
      print(e);
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }
}

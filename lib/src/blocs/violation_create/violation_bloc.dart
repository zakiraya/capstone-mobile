import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation_branch.dart';
import 'package:capstone_mobile/src/data/models/violation/violation_description.dart';
import 'package:capstone_mobile/src/data/models/violation/violation_regulation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

part 'violation_event.dart';
part 'violation_state.dart';

class ViolationCreateBloc
    extends Bloc<ViolationCreateEvent, ViolationCreateState> {
  ViolationCreateBloc() : super(ViolationCreateState());

  @override
  Stream<ViolationCreateState> mapEventToState(
    ViolationCreateEvent event,
  ) async* {
    if (event is ViolationDescriptionChanged) {
      yield _mapViolationDescriptionToState(event, state);
    } else if (event is ViolationRegulationChanged) {
      yield _mapViolationRegulationChangetoState(event, state);
    } else if (event is ViolationBranchChanged) {
      yield _mapViolationBranchChangetoState(event, state);
    } else if (event is ViolationAdded) {
      yield* _mapViolationCreateAddedToState(event, state);
    }
  }
}

ViolationCreateState _mapViolationRegulationChangetoState(
    ViolationRegulationChanged event, ViolationCreateState state) {
  final regulationId = ViolationRegulation.dirty(event.violationRegulation);
  // state.props.remove(state?.reportBranch);
  return state.copyWith(
    violationRegulation: regulationId,
    status: Formz.validate([
      state.violationDescription,
      regulationId,
      state.violationBranch,
    ]),
  );
}

ViolationCreateState _mapViolationBranchChangetoState(
    ViolationBranchChanged event, ViolationCreateState state) {
  final branchId = ViolationBranch.dirty(event.branchId);
  return state.copyWith(
    violationBranch: branchId,
    status: Formz.validate([
      state.violationDescription,
      state.violationRegulation,
      branchId,
    ]),
  );
}

ViolationCreateState _mapViolationDescriptionToState(
    ViolationDescriptionChanged event, ViolationCreateState state) {
  final violationDescription =
      ViolationDescription.dirty(event.violationDescription);
  return state.copyWith(
    violationDescription: violationDescription,
    status: Formz.validate(
      [
        violationDescription,
        state.violationRegulation,
        state.violationBranch,
      ],
    ),
  );
}

Stream<ViolationCreateState> _mapViolationCreateAddedToState(
    ViolationAdded event, ViolationCreateState state) async* {
  if (state.status.isValidated) {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      DateTime date = DateTime.now();
      print('violation create: ');
      print(state.violationDescription.value);
      print(state.violationRegulation.value);
      print(state.name);
      print(state.createdDate);
      yield state.copyWith(
        status: FormzStatus.submissionSuccess,
        createdDate: formatDate(date),
        name: 'violation name',
      );
    } catch (e) {
      print(e);
      yield state.copyWith(status: FormzStatus.invalid);
    }
  }
}

String formatDate(DateTime date) {
  return date.day.toString().padLeft(2, '0') +
      '-' +
      date.month.toString().padLeft(2, '0') +
      '-' +
      date.year.toString();
}

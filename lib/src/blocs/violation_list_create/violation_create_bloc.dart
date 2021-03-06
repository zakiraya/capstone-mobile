import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_mobile/src/data/models/branch/branch.dart';
import 'package:capstone_mobile/src/data/models/regulation/regulation.dart';
import 'package:capstone_mobile/src/data/models/violation/violation_description.dart';
import 'package:capstone_mobile/src/data/models/violation/violation_regulation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

part 'violation_create_event.dart';
part 'violation_create_state.dart';

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
    }
    //  else if (event is ViolationBranchChanged) {
    //   yield _mapViolationBranchChangetoState(event, state);
    // }
    else if (event is ViolationAdded) {
      yield* _mapViolationCreateAddedToState(event, state);
    }
  }
}

ViolationCreateState _mapViolationRegulationChangetoState(
    ViolationRegulationChanged event, ViolationCreateState state) {
  final regulation = ViolationRegulation.dirty(event.regulation);
  return state.copyWith(
    violationRegulation: regulation,
    status: Formz.validate([
      state.violationDescription,
      regulation,
      // state.violationBranch,
    ]),
  );
}

// ViolationCreateState _mapViolationBranchChangetoState(
//     ViolationBranchChanged event, ViolationCreateState state) {
//   final branch = ViolationBranch.dirty(event.branch);
//   return state.copyWith(
//     violationBranch: branch,
//     status: Formz.validate([
//       state.violationDescription,
//       state.violationRegulation,
//       branch,
//     ]),
//   );
// }

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
        // state.violationBranch,
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

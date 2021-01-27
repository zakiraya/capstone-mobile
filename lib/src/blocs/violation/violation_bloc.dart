import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_mobile/src/data/models/violation.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'violation_event.dart';
part 'violation_state.dart';

class ViolationBloc extends Bloc<ViolationEvent, ViolationState> {
  ViolationBloc({@required this.violationRepository})
      : super(ViolationInitial());

  final ViolationRepository violationRepository;
  @override
  Stream<ViolationState> mapEventToState(
    ViolationEvent event,
  ) async* {
    if (event is ViolationRequested) {
      yield ViolationLoadInProgress();
      try {
        final List<Violation> violations =
            await violationRepository.fetchViolations(token: "token");
        yield ViolationLoadSuccess(violations: violations);
      } catch (e) {
        print(e);
        yield ViolationLoadFailure();
      }
    }
  }
}

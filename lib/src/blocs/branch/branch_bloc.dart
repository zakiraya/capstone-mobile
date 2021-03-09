import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:capstone_mobile/src/data/models/branch/branch.dart';
import 'package:capstone_mobile/src/data/repositories/branch/branch_repository.dart';
part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  final BranchRepository branchRepository;
  BranchBloc({this.branchRepository}) : super(BranchInitial());

  @override
  Stream<BranchState> mapEventToState(
    BranchEvent event,
  ) async* {
    if (event is BranchRequested) {
      try {
        yield BranchLoadInProgress();
        var branches = await branchRepository.fetchBranches(event.token);
        yield BranchLoadSuccess(branches: branches);
      } catch (e) {
        yield BranchLoadFailure();
      }
    }
  }
}

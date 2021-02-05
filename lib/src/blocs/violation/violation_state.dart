part of 'violation_bloc.dart';

abstract class ViolationState extends Equatable {
  const ViolationState();

  @override
  List<Object> get props => [];
}

class ViolationInitial extends ViolationState {}

class ViolationLoadInProgress extends ViolationState {}

class ViolationLoadSuccess extends ViolationState {
  final List<Violation> violations;

  const ViolationLoadSuccess({@required this.violations});

  ViolationLoadSuccess copyWith({List<String> violations}) {
    return ViolationLoadSuccess(violations: violations ?? this.violations);
  }
}

class ViolationLoadFailure extends ViolationState {}

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
  final bool hasReachedMax;

  const ViolationLoadSuccess({@required this.violations, this.hasReachedMax});

  ViolationLoadSuccess copyWith({
    List<String> violations,
    bool hasReachedMax,
  }) {
    return ViolationLoadSuccess(
      violations: violations ?? this.violations,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [violations, hasReachedMax];
}

class ViolationLoadFailure extends ViolationState {}

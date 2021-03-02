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
  final String screen;

  const ViolationLoadSuccess({
    @required this.violations,
    this.hasReachedMax,
    this.screen,
  });

  ViolationLoadSuccess copyWith({
    List<Violation> violations,
    bool hasReachedMax,
    String screen,
  }) {
    return ViolationLoadSuccess(
      violations: violations ?? this.violations,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      screen: screen,
    );
  }

  @override
  List<Object> get props => [violations, hasReachedMax];

  @override
  String toString() =>
      'ViolationLoadSuccess { violation total: ${violations.length} }';
}

class ViolationLoadFailure extends ViolationState {}

part of 'violation_bloc.dart';

abstract class ViolationEvent extends Equatable {
  const ViolationEvent();

  @override
  List<Object> get props => [];
}

class ViolationRequested extends ViolationEvent {
  const ViolationRequested({
    @required this.token,
    this.filter,
    this.isRefresh = false,
  });

  final String token;
  final bool isRefresh;
  final ViolationFilter filter;

  @override
  List<Object> get props => [token, filter, isRefresh];
}

class ViolationUpdate extends ViolationEvent {
  const ViolationUpdate({
    @required this.token,
    @required this.violation,
  });

  final String token;
  final Violation violation;

  @override
  List<Object> get props => [token, violation];
}

class ViolationDelete extends ViolationEvent {
  const ViolationDelete({
    @required this.token,
    @required this.id,
  });

  final String token;
  final int id;

  @override
  List<Object> get props => [token, id];
}

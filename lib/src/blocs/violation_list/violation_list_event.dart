part of 'violation_list_bloc.dart';

abstract class ViolationListEvent extends Equatable {
  const ViolationListEvent();

  @override
  List<Object> get props => [];
}

class ViolationListChanged extends ViolationListEvent {
  const ViolationListChanged({@required this.violation});

  final Violation violation;

  @override
  List<Object> get props => [violation];
}

class ViolationUpdate extends ViolationListEvent {
  const ViolationUpdate({@required this.position, @required this.violation});

  final Violation violation;
  final int position;

  @override
  List<Object> get props => [position, violation];
}

class ViolationListRemove extends ViolationListEvent {
  const ViolationListRemove({@required this.position});

  final int position;

  @override
  List<Object> get props => [position];
}

class ViolationListSubmitted extends ViolationListEvent {
  const ViolationListSubmitted({@required this.token});

  final String token;

  @override
  List<Object> get props => [token];
}
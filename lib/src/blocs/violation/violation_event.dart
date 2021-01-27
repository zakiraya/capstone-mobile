part of 'violation_bloc.dart';

abstract class ViolationEvent extends Equatable {
  const ViolationEvent();

  @override
  List<Object> get props => [];
}

class ViolationRequested extends ViolationEvent {
  const ViolationRequested({@required this.token});

  final String token;

  @override
  List<Object> get props => [token];
}

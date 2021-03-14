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
  final Filter filter;

  @override
  List<Object> get props => [token, filter, isRefresh];

  @override
  String toString() =>
      ' ViolationRequested: { ${filter.toString()}, $isRefresh }';
}

class FilterChanged extends ViolationEvent {
  const FilterChanged({
    @required this.token,
    this.filter,
  });

  final String token;
  final Filter filter;

  @override
  List<Object> get props => [token, filter];

  @override
  String toString() => ' FilterChanged: { ${filter.toString()} } ';
}

class ViolationUpdate extends ViolationEvent {
  const ViolationUpdate();

  @override
  List<Object> get props => [];
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

class ViolationAuthenticationStatusChanged extends ViolationEvent {
  const ViolationAuthenticationStatusChanged({this.status});

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

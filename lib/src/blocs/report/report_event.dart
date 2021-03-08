part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class ReportRequested extends ReportEvent {
  const ReportRequested({
    @required this.token,
    this.filter,
    this.isRefresh,
  });

  final String token;
  final Filter filter;
  final bool isRefresh;

  @override
  List<Object> get props => [token, filter];

  @override
  String toString() =>
      ' ReportRequested: { Filter: ${filter.toString()}, Refresh: $isRefresh }';
}

class FilterChanged extends ReportEvent {
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

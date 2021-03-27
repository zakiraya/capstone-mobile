part of 'report_by_demand_bloc.dart';

abstract class ReportByDemandEvent extends Equatable {
  const ReportByDemandEvent();

  @override
  List<Object> get props => [];
}

class ReportByDemandRequested extends ReportByDemandEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => ' ReportRequested ';
}

class ReportByDemandUpdated extends ReportByDemandEvent {
  const ReportByDemandUpdated({this.report});

  final Report report;

  @override
  List<Object> get props => [report];
}

class ReportByDemandDeleted extends ReportByDemandEvent {
  const ReportByDemandDeleted({this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoadInProgress extends ReportState {}

class ReportLoadSuccess extends ReportState {
  final List<Report> reports;

  const ReportLoadSuccess({@required this.reports});

  ReportLoadSuccess copyWith({List<Report> reports}) {
    return ReportLoadSuccess(reports: reports ?? this.reports);
  }
}

class ReportLoadFailure extends ReportState {}

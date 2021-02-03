part of 'report_create_bloc.dart';

class ReportCreateState extends Equatable {
  const ReportCreateState({
    this.status = FormzStatus.pure,
    this.reportName = const ReportName.pure(),
    this.reportDescription = const ReportDescription.pure(),
    this.reportBranch = const ReportBranch.pure(),
    this.reportListViolation = const ReportListViolation.pure(),
  });

  final FormzStatus status;
  final ReportName reportName;
  final ReportDescription reportDescription;
  final ReportBranch reportBranch;
  final ReportListViolation reportListViolation;

  ReportCreateState copyWith(
      {FormzStatus status,
      ReportName reportName,
      ReportDescription reportDescription,
      ReportBranch reportBranch,
      ReportListViolation reportListViolation}) {
    return ReportCreateState(
      status: status ?? this.status,
      reportName: reportName ?? this.reportName,
      reportDescription: reportDescription ?? this.reportDescription,
      reportBranch: reportBranch ?? this.reportBranch,
      reportListViolation: reportListViolation ?? this.reportListViolation,
    );
  }

  @override
  List<Object> get props => [
        status,
        reportName,
        reportDescription,
        reportBranch,
        reportListViolation
      ];
}

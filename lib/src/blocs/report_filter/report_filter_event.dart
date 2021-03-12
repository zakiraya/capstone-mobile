part of 'report_filter_bloc.dart';

abstract class ReportFilterEvent extends Equatable {
  const ReportFilterEvent();

  @override
  List<Object> get props => [];
}

class ReportFilterBranchIdUpdated extends ReportFilterEvent {
  final int branchId;

  ReportFilterBranchIdUpdated({this.branchId});
  @override
  String toString() => 'ReportFilterBranchIdUpdated { BranchId: $branchId  }';
}

class ReportFilterRegulationUpdated extends ReportFilterEvent {
  final int regulationId;

  ReportFilterRegulationUpdated({this.regulationId});
  @override
  String toString() =>
      'ReportFilterRegulationUpdated { RegulationId: $regulationId  }';
}

class ReportFilterStatusUpdated extends ReportFilterEvent {
  final String status;

  ReportFilterStatusUpdated({this.status});
  @override
  String toString() => 'ReportFilterStatusUpdated { Status: $status  }';
}

class ReportFilterMonthUpdated extends ReportFilterEvent {
  final DateTime month;

  ReportFilterMonthUpdated({this.month});
  @override
  String toString() => 'ReportFilterStatusUpdated { Month: $month  }';
}

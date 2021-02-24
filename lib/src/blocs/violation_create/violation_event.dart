part of 'violation_bloc.dart';

abstract class ViolationCreateEvent extends Equatable {
  const ViolationCreateEvent();

  @override
  List<Object> get props => [];
}

class ViolationDescriptionChanged extends ViolationCreateEvent {
  const ViolationDescriptionChanged({@required this.violationDescription});

  final String violationDescription;

  @override
  List<Object> get props => [violationDescription];
}

class ViolationRegulationChanged extends ViolationCreateEvent {
  const ViolationRegulationChanged({@required this.regulation});

  final Regulation regulation;

  @override
  List<Object> get props => [regulation];
}

class ViolationBranchChanged extends ViolationCreateEvent {
  const ViolationBranchChanged({@required this.branch});

  final Branch branch;

  @override
  List<Object> get props => [branch];
}

class ViolationAdded extends ViolationCreateEvent {
  const ViolationAdded();

  @override
  List<Object> get props => [];
}

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
  const ViolationRegulationChanged({@required this.violationRegulation});

  final int violationRegulation;

  @override
  List<Object> get props => [violationRegulation];
}

class ViolationAdded extends ViolationCreateEvent {
  const ViolationAdded();

  @override
  List<Object> get props => [];
}

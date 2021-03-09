part of 'branch_bloc.dart';

abstract class BranchEvent extends Equatable {
  const BranchEvent();

  @override
  List<Object> get props => [];
}

class BranchRequested extends BranchEvent {
  final String token;

  BranchRequested({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => ' BranchRequested ';
}

part of 'repair_bloc.dart';

abstract class RepairState extends Equatable {
  const RepairState();
  
  @override
  List<Object> get props => [];
}

class RepairInitial extends RepairState {}

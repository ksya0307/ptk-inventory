part of 'repair_bloc.dart';

class RepairEvent extends Equatable {
  const RepairEvent();

  @override
  List<Object> get props => [];
}

class RepairProblemChanged extends RepairEvent {
  final String problem;

  const RepairProblemChanged(this.problem);
  @override
  List<Object> get props => [problem];
}

class RepairPhoneChanged extends RepairEvent {
  final String phone;

  const RepairPhoneChanged(this.phone);
  @override
  List<Object> get props => [phone];
}

class RepairDateTimeChanged extends RepairEvent {
  final DateTime dateTime;

  const RepairDateTimeChanged(this.dateTime);
  @override
  List<Object> get props => [dateTime];
}

class RepairEquipmentChanged extends RepairEvent {
  final ClassroomEquipment? selectedEquipment;
  const RepairEquipmentChanged(this.selectedEquipment);
  @override
  List<Object> get props => [selectedEquipment!];
}

class RepairSubmitted extends RepairEvent {
  const RepairSubmitted();
}

class RepairSaved extends RepairEvent {
  const RepairSaved();
}

class RepairLoadList extends RepairEvent {
  const RepairLoadList();
}

class RepairUserLoadList extends RepairEvent {
  const RepairUserLoadList();
}

class RepairSearch extends RepairEvent {
  final String matchingWord;

  const RepairSearch({required this.matchingWord});

  @override
  List<Object> get props => [matchingWord];
}

class RepairmDeleted extends RepairEvent {
  final int id;
  const RepairmDeleted(this.id);
  @override
  List<Object> get props => [id];
}

class RepairSelected extends RepairEvent {
  final RepairEquipment? selectedRepairEquipment;

  const RepairSelected(this.selectedRepairEquipment);
}

class RepairDeleteFromList extends RepairEvent {
  final RepairEquipment repairEquipment;
  const RepairDeleteFromList({required this.repairEquipment});
  @override
  List<Object> get props => [repairEquipment];
}

class RepairSaveToList extends RepairEvent {
  final RepairEquipment repairEquipment;
  const RepairSaveToList({required this.repairEquipment});
  @override
  List<Object> get props => [repairEquipment];
}

class RepairShowDocument extends RepairEvent {
  const RepairShowDocument();
}

class RepairSaveDocument extends RepairEvent {
  const RepairSaveDocument();
}

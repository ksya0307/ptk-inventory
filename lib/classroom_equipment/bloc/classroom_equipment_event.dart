part of 'classroom_equipment_bloc.dart';

class ClassroomEquipmentEvent extends Equatable {
  const ClassroomEquipmentEvent();

  @override
  List<Object> get props => [];
}

class ClassroomEquipmentLoadUserEquipmentsList extends ClassroomEquipmentEvent {
  const ClassroomEquipmentLoadUserEquipmentsList();
}

class ClassroomEquipmentUserSelected extends ClassroomEquipmentEvent {
  final ClassroomEquipment? selectedEquipment;
  const ClassroomEquipmentUserSelected(this.selectedEquipment);
}

class ClassroomEquipmentSearch extends ClassroomEquipmentEvent {
  final String matchingWord;

  const ClassroomEquipmentSearch(this.matchingWord);
}
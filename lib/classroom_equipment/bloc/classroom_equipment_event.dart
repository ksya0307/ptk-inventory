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

class ClassroomEquipmentFilteredEquipment extends ClassroomEquipmentEvent {
  final ClassroomEquipment? filteredEquipment;
  const ClassroomEquipmentFilteredEquipment(this.filteredEquipment);
}

class ClassroomEquipmentSelectedClassroom extends ClassroomEquipmentEvent {
  final Classroom? selectedClassroom;

  const ClassroomEquipmentSelectedClassroom(this.selectedClassroom);
}

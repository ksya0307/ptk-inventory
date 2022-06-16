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

class ClassroomEquipmentLoadSpecs extends ClassroomEquipmentEvent {
  const ClassroomEquipmentLoadSpecs();
}

class ClassroomEquipmentSpecsChanged extends ClassroomEquipmentEvent {
  final String specs;
  const ClassroomEquipmentSpecsChanged(this.specs);
  @override
  List<Object> get props => [specs];
}

class ClassroomEquipmentSpecsSubmitted extends ClassroomEquipmentEvent {
  const ClassroomEquipmentSpecsSubmitted();
}

class ClassroomEquipmentSpecsSaved extends ClassroomEquipmentEvent {
  const ClassroomEquipmentSpecsSaved();
}

class ClassroomEquipmentSpecsSearch extends ClassroomEquipmentEvent {
  const ClassroomEquipmentSpecsSearch({required this.matchingWord});
  final String matchingWord;
}

class ClassroomEquipmentSpecsDeleted extends ClassroomEquipmentEvent {
  final int id;
  const ClassroomEquipmentSpecsDeleted(this.id);
  @override
  List<Object> get props => [id];
}

class ClassroomEquipmentSpecsDeleteFromList extends ClassroomEquipmentEvent {
  final Equipment equipment;
  const ClassroomEquipmentSpecsDeleteFromList({required this.equipment});
  @override
  List<Object> get props => [equipment];
}

class ClassroomEquipmentSpecsSaveToList extends ClassroomEquipmentEvent {
  final Equipment equipment;
  const ClassroomEquipmentSpecsSaveToList({required this.equipment});
  @override
  List<Object> get props => [equipment];
}

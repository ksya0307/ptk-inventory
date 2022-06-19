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

class ClassroomEquipmentNotInInventory extends ClassroomEquipmentEvent {
  const ClassroomEquipmentNotInInventory();
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

class ClassroomEquipmentSpecsCategorySelected extends ClassroomEquipmentEvent {
  final Category? selectedCategory;
  const ClassroomEquipmentSpecsCategorySelected(this.selectedCategory);
}

class ClassroomEquipmentSpecsSelected extends ClassroomEquipmentEvent {
  final Equipment? selectedSpecs;
  const ClassroomEquipmentSpecsSelected(this.selectedSpecs);
}

class ClassroomEquipmentInventoryNumberChanged extends ClassroomEquipmentEvent {
  final String inventoryNumber;
  const ClassroomEquipmentInventoryNumberChanged(this.inventoryNumber);
  @override
  List<Object> get props => [inventoryNumber];
}

class ClassroomEquipmentInternalNumberChanged extends ClassroomEquipmentEvent {
  final String internalNumber;
  const ClassroomEquipmentInternalNumberChanged(this.internalNumber);
  @override
  List<Object> get props => [internalNumber];
}

class ClassroomEquipmentTypeChanged extends ClassroomEquipmentEvent {
  final EquipmentBelonging type;
  const ClassroomEquipmentTypeChanged(this.type);
  @override
  List<Object> get props => [type];
}

class ClassroomEquipmentSpecsByCategory extends ClassroomEquipmentEvent {
  final int categoryId;
  const ClassroomEquipmentSpecsByCategory(this.categoryId);
  @override
  List<Object> get props => [categoryId];
}

class ClassroomEquipmentFilteredSpecs extends ClassroomEquipmentEvent {
  const ClassroomEquipmentFilteredSpecs();
}

class ClassroomEquipmentCreated extends ClassroomEquipmentEvent {
  const ClassroomEquipmentCreated();
}

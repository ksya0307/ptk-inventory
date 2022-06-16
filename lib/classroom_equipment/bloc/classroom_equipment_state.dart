// ignore_for_file: must_be_immutable

part of 'classroom_equipment_bloc.dart';

enum ClassroomEquipmentLoadingStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}

enum EquipmentActionStatus {
  pure,
  deleted,
  notDeleted,
  deletedFromGlobal,
  savedOnGlobal,
  saved,
  notSaved,
  added,
  notAdded,
  addedToGlobal,
}

class ClassroomEquipmentState extends Equatable {
  final FormzStatus formStatus;
  final EquipmentActionStatus equipmentActionStatus;
  final ClassroomEquipmentLoadingStatus classroomEquipmentLoadingStatus;
  final ClassroomEquipment? selectedEquipment;
  final List<ClassroomEquipment> filteredEquipment;
  final List<ClassroomEquipment> globalEquipments;
  final List<ClassroomEquipment> visibleList;
  final String searchText;
  final Specs specs;
  final Category? selectedCategory;
  final Equipment? selectedSpecs;
  final List<Equipment> globalSpecs;
  final List<Equipment> specsVisibleList;

  const ClassroomEquipmentState({
    this.specsVisibleList = const [],
    this.globalSpecs = const [],
    this.selectedSpecs,
    this.selectedCategory,
    this.formStatus = FormzStatus.pure,
    this.specs = const Specs.pure(),
    this.equipmentActionStatus = EquipmentActionStatus.pure,
    this.classroomEquipmentLoadingStatus = ClassroomEquipmentLoadingStatus.pure,
    this.selectedEquipment,
    this.globalEquipments = const [],
    this.visibleList = const [],
    this.searchText = "",
    this.filteredEquipment = const [],
  });

  @override
  List<Object?> get props => [
    specsVisibleList,
            globalSpecs,
        selectedSpecs,
        selectedCategory,
        specs,
        formStatus,
        classroomEquipmentLoadingStatus,
        equipmentActionStatus,
        searchText,
        selectedEquipment,
        filteredEquipment,
        globalEquipments,
        visibleList
      ];

  ClassroomEquipmentState copyWith({
    FormzStatus? formStatus,
    EquipmentActionStatus? equipmentActionStatus,
    ClassroomEquipmentLoadingStatus? classroomEquipmentLoadingStatus,
    ClassroomEquipment? selectedEquipment,
    List<ClassroomEquipment>? filteredEquipment,
    List<ClassroomEquipment>? globalEquipments,
    List<ClassroomEquipment>? visibleList,
    String? searchText,
    Specs? specs,
    Category? selectedCategory,
    Equipment? selectedSpecs,
    List<Equipment>? globalSpecs,
    List<Equipment>? specsVisibleList,
  }) {
    return ClassroomEquipmentState(
      formStatus: formStatus ?? this.formStatus,
      equipmentActionStatus: equipmentActionStatus ?? this.equipmentActionStatus,
      classroomEquipmentLoadingStatus: classroomEquipmentLoadingStatus ?? this.classroomEquipmentLoadingStatus,
      selectedEquipment: selectedEquipment ?? this.selectedEquipment,
      filteredEquipment: filteredEquipment ?? this.filteredEquipment,
      globalEquipments: globalEquipments ?? this.globalEquipments,
      visibleList: visibleList ?? this.visibleList,
      searchText: searchText ?? this.searchText,
      specs: specs ?? this.specs,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSpecs: selectedSpecs ?? this.selectedSpecs,
      globalSpecs: globalSpecs ?? this.globalSpecs,
      specsVisibleList: specsVisibleList ?? this.specsVisibleList,
    );
  }
}

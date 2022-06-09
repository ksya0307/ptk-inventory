part of 'classroom_equipment_bloc.dart';

enum ClassroomEquipmentLoadingStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}

class ClassroomEquipmentState extends Equatable {
  final ClassroomEquipmentLoadingStatus classroomEquipmentLoadingStatus;
  final ClassroomEquipment? selectedEquipment;
  final ClassroomEquipment? filteredEquipment;
  final List<ClassroomEquipment> globalEquipments;
  final List<ClassroomEquipment> visibleList;
  final String searchText;
  const ClassroomEquipmentState({
    this.classroomEquipmentLoadingStatus = ClassroomEquipmentLoadingStatus.pure,
    this.selectedEquipment,
    this.globalEquipments = const [],
    this.visibleList = const [],
    this.searchText = "",
    this.filteredEquipment,
  });

  @override
  List<Object?> get props => [
        classroomEquipmentLoadingStatus,
        searchText,
        selectedEquipment,
        filteredEquipment,
        globalEquipments,
        visibleList
      ];

  ClassroomEquipmentState copyWith({
    ClassroomEquipmentLoadingStatus? classroomEquipmentLoadingStatus,
    ClassroomEquipment? selectedEquipment,
    ClassroomEquipment? filteredEquipment,
    List<ClassroomEquipment>? globalEquipments,
    List<ClassroomEquipment>? visibleList,
    String? searchText,
  }) {
    return ClassroomEquipmentState(
      classroomEquipmentLoadingStatus: classroomEquipmentLoadingStatus ??
          this.classroomEquipmentLoadingStatus,
      selectedEquipment: selectedEquipment ?? this.selectedEquipment,
      filteredEquipment: filteredEquipment ?? this.filteredEquipment,
      globalEquipments: globalEquipments ?? this.globalEquipments,
      visibleList: visibleList ?? this.visibleList,
      searchText: searchText ?? this.searchText,
    );
  }
}

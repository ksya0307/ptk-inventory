part of 'repair_bloc.dart';

enum RepairLoadingStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}
enum RepairActionStatus {
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

class RepairState extends Equatable {
  final List<RepairEquipment> globalRepairEquipment;
  final List<RepairEquipment> visibleList;
  final RepairLoadingStatus repairLoadingStatus;
  final RepairActionStatus repairActionStatus;
  final FormzStatus formStatus;
  final Problem problem;
  final Phone phone;
  final bool? isCompleted;
  final ClassroomEquipment? selectedEquipment;
  final DateTime? dateTime;
  final String searchText;
  final RepairEquipment? selectedRepairEquipment;

  RepairState({
    this.visibleList = const [],
    this.globalRepairEquipment = const [],
    this.searchText = "",
    this.selectedRepairEquipment,
    this.repairLoadingStatus = RepairLoadingStatus.pure,
    this.repairActionStatus = RepairActionStatus.pure,
    this.formStatus = FormzStatus.pure,
    this.problem = const Problem.pure(),
    this.phone = const Phone.pure(),
    this.isCompleted,
    this.selectedEquipment,
    DateTime? creationDate,
  }) : dateTime = creationDate ?? DateTime.now();

  @override
  List<Object?> get props => [
        repairActionStatus,
        repairLoadingStatus,
        formStatus,
        problem,
        isCompleted,
        phone,
        visibleList,
        globalRepairEquipment,
        selectedEquipment,
        dateTime,
        searchText,
        selectedRepairEquipment
      ];

  RepairState copyWith({
    List<RepairEquipment>? globalRepairEquipment,
    List<RepairEquipment>? visibleList,
    RepairLoadingStatus? repairLoadingStatus,
    RepairActionStatus? repairActionStatus,
    FormzStatus? formStatus,
    Problem? problem,
    Phone? phone,
    bool? isCompleted,
    ClassroomEquipment? selectedEquipment,
    DateTime? dateTime,
    String? searchText,
    RepairEquipment? selectedRepairEquipment,
  }) {
    return RepairState(
      globalRepairEquipment:
          globalRepairEquipment ?? this.globalRepairEquipment,
      visibleList: visibleList ?? this.visibleList,
      repairLoadingStatus: repairLoadingStatus ?? this.repairLoadingStatus,
      repairActionStatus: repairActionStatus ?? this.repairActionStatus,
      formStatus: formStatus ?? this.formStatus,
      problem: problem ?? this.problem,
      phone: phone ?? this.phone,
      isCompleted: isCompleted ?? this.isCompleted,
      selectedEquipment: selectedEquipment ?? this.selectedEquipment,
      creationDate: dateTime ?? this.dateTime,
      searchText: searchText ?? this.searchText,
      selectedRepairEquipment:
          selectedRepairEquipment ?? this.selectedRepairEquipment,
    );
  }
}

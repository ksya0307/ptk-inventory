part of 'inventory_bloc.dart';

enum InventoryLoadingStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}

enum InventoryActionStatus {
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
  emptyFields
}

class InventoryState extends Equatable {
  final FormzStatus formStatus;
  final List<Inventory> globalInventory;
  final List<Inventory> visibleList;
  final InventoryActionStatus inventoryActionStatus;
  final InventoryLoadingStatus inventoryLoadingStatus;
  final String searchText;
  final DateTime? getDate;
  final ClassroomEquipment? selectedEquipment;
  final Classroom? selectedClassroom;
  final Document? selectedDocument;
  final Ifo? selectedIfo;
  final bool given;
  final bool byRequest;
  final Inventory? inventory;
  final String? comment;

  InventoryState({
    this.comment,
    this.formStatus = FormzStatus.pure,
    this.inventoryActionStatus = InventoryActionStatus.pure,
    this.inventoryLoadingStatus = InventoryLoadingStatus.pure,
    this.selectedEquipment,
    this.searchText = "",
    this.selectedClassroom,
    this.given = false,
    this.byRequest = false,
    this.selectedDocument,
    this.selectedIfo,
    this.inventory,
    this.globalInventory = const [],
    this.visibleList = const [],
    DateTime? getInventoryDate,
  }) : getDate = getInventoryDate ?? DateTime.now();

  @override
  List<Object?> get props => [
    visibleList,
        globalInventory,
        comment,
        formStatus,
        inventory,
        inventoryActionStatus,
        inventoryLoadingStatus,
        selectedEquipment,
        selectedDocument,
        selectedClassroom,
        selectedIfo,
        searchText,
        given,
        byRequest,
        getDate,
      ];

  InventoryState copyWith({
    FormzStatus? formStatus,
    List<Inventory>? globalInventory,
    List<Inventory>? visibleList,
    InventoryActionStatus? inventoryActionStatus,
    InventoryLoadingStatus? inventoryLoadingStatus,
    String? searchText,
    DateTime? getDate,
    ClassroomEquipment? selectedEquipment,
    Classroom? selectedClassroom,
    Document? selectedDocument,
    Ifo? selectedIfo,
    bool? given,
    bool? byRequest,
    Inventory? inventory,
    String? comment,
  }) {
    return InventoryState(
      formStatus: formStatus ?? this.formStatus,
      globalInventory: globalInventory ?? this.globalInventory,
      visibleList: visibleList ?? this.visibleList,
      inventoryActionStatus: inventoryActionStatus ?? this.inventoryActionStatus,
      inventoryLoadingStatus: inventoryLoadingStatus ?? this.inventoryLoadingStatus,
      searchText: searchText ?? this.searchText,
      getInventoryDate: getDate ?? this.getDate,
      selectedEquipment: selectedEquipment ?? this.selectedEquipment,
      selectedClassroom: selectedClassroom ?? this.selectedClassroom,
      selectedDocument: selectedDocument ?? this.selectedDocument,
      selectedIfo: selectedIfo ?? this.selectedIfo,
      given: given ?? this.given,
      byRequest: byRequest ?? this.byRequest,
      inventory: inventory ?? this.inventory,
      comment: comment ?? this.comment,
    );
  }
}

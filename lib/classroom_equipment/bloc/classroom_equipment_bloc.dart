import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/category/model/category.dart';
import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment.dart';
import 'package:ptk_inventory/classroom_equipment/model/equipment/model/equipment.dart';
import 'package:ptk_inventory/classroom_equipment/model/equipment_types.dart';
import 'package:ptk_inventory/classroom_equipment/model/inventory_number.dart';
import 'package:ptk_inventory/classroom_equipment/model/requests/create_equipment_request.dart';
import 'package:ptk_inventory/classroom_equipment/model/requests/create_specs_request.dart';
import 'package:ptk_inventory/classroom_equipment/model/requests/update_specs_request.dart';
import 'package:ptk_inventory/classroom_equipment/model/specs.dart';
import 'package:ptk_inventory/classroom_equipment/repository/classroom_equipment_repository.dart';
import 'package:ptk_inventory/classrooms/model/classroom.dart';

part 'classroom_equipment_event.dart';
part 'classroom_equipment_state.dart';

class ClassroomEquipmentBloc
    extends Bloc<ClassroomEquipmentEvent, ClassroomEquipmentState> {
  ClassroomEquipmentBloc({
    required ClassroomEquipmentRepository classroomEquipmentRepository,
  })  : _classroomEquipmentRepository = classroomEquipmentRepository,
        super(const ClassroomEquipmentState()) {
    on<ClassroomEquipmentLoadUserEquipmentsList>(_onLoadUserEquipmentList);
    on<ClassroomEquipmentSearch>(_onSearch);
    on<ClassroomEquipmentUserSelected>(_onSelected);
    on<ClassroomEquipmentFilteredEquipment>(_onFiltered);
    on<ClassroomEquipmentSelectedClassroom>(_selectedClassroom);
    on<ClassroomEquipmentCreated>(_onCreated);
    on<ClassroomEquipmentNotInInventory>(_onNotInInventory);

    //Specs
    on<ClassroomEquipmentLoadSpecs>(_onLoadSpecs);
    on<ClassroomEquipmentFilteredSpecs>(_onFilteredSpecs);
    //on<ClassroomEquipmentSpecsByCategory>(_onLoadSpecsByCategory);

    on<ClassroomEquipmentSpecsSaved>(_onSavedSpecs);
    on<ClassroomEquipmentSpecsDeleted>(_onDeletedSpecs);
    on<ClassroomEquipmentSpecsSubmitted>(_onSubmitted);

    on<ClassroomEquipmentSpecsDeleteFromList>(_onDeleteFromList);
    on<ClassroomEquipmentSpecsSaveToList>(_onSaveToList);

    on<ClassroomEquipmentInventoryNumberChanged>(_onInventoryNumberChanged);
    on<ClassroomEquipmentInternalNumberChanged>(_onInternalNumberChanged);
    on<ClassroomEquipmentTypeChanged>(_onTypeChanged);

    on<ClassroomEquipmentSpecsChanged>(_onSpecsChanged);
    on<ClassroomEquipmentSpecsSearch>(_onSearchSpecs);
    on<ClassroomEquipmentSpecsCategorySelected>(_onSelectedCategory);
    on<ClassroomEquipmentSpecsSelected>(_onSelectedSpecs);
  }

  final ClassroomEquipmentRepository _classroomEquipmentRepository;

  Future<void> _onSelectedCategory(
    ClassroomEquipmentSpecsCategorySelected event,
    Emitter<ClassroomEquipmentState> emit,
  ) async {
    emit(
      state.copyWith(
        classroomEquipmentLoadingStatus:
            ClassroomEquipmentLoadingStatus.loadingInProgress,
      ),
    );
    if (event.selectedCategory == null) {
      emit(
        state.copyWith(
          equipmentActionStatus: EquipmentActionStatus.emptyFields,
        ),
      );
      emit(
        state.copyWith(
          equipmentActionStatus: EquipmentActionStatus.pure,
        ),
      );
    } else {
      final waiting = await _classroomEquipmentRepository.specsByCategory(
        categoryId: event.selectedCategory!.id,
      );
      if (waiting.isNotEmpty) {
        waiting.sort((a, b) => a.id.compareTo(b.id));
      }
      emit(
        state.copyWith(
          selectedCategory: event.selectedCategory,
          globalSpecs: waiting,
          classroomEquipmentLoadingStatus:
              ClassroomEquipmentLoadingStatus.loadingSuccess,
        ),
      );
    }
  }

  Future<void> _onNotInInventory(
    ClassroomEquipmentNotInInventory event,
    Emitter<ClassroomEquipmentState> emit,
  ) async {
    emit(
      state.copyWith(
        classroomEquipmentLoadingStatus:
            ClassroomEquipmentLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _classroomEquipmentRepository.notInInventory();
    if (waiting.isNotEmpty) {
      waiting.sort(
        (a, b) => a.equipment.category.name.compareTo(
          b.equipment.category.name,
        ),
      );
    }
    emit(
      state.copyWith(
        globalEquipments: waiting,
        classroomEquipmentLoadingStatus:
            ClassroomEquipmentLoadingStatus.loadingSuccess,
      ),
    );
  }

  void _onFilteredSpecs(
    ClassroomEquipmentFilteredSpecs event,
    Emitter<ClassroomEquipmentState> emit,
  ) {}

  void _onSelectedSpecs(
    ClassroomEquipmentSpecsSelected event,
    Emitter<ClassroomEquipmentState> emit,
  ) {
    emit(state.copyWith(selectedSpecs: event.selectedSpecs));
  }

  void _onSearchSpecs(
    ClassroomEquipmentSpecsSearch event,
    Emitter<ClassroomEquipmentState> emit,
  ) {
    List<Equipment> finalList = [];
    if (event.matchingWord.isNotEmpty) {
      finalList = state.globalSpecs
          .where(
            (specs) => specs.description.toLowerCase().contains(
                  event.matchingWord.toLowerCase(),
                ),
          )
          .toList();
    }

    emit(
      state.copyWith(
        specsVisibleList: finalList,
        searchText: event.matchingWord,
      ),
    );
  }

  void _onDeleteFromList(
    ClassroomEquipmentSpecsDeleteFromList event,
    Emitter<ClassroomEquipmentState> emit,
  ) {}

  void _onSaveToList(
    ClassroomEquipmentSpecsSaveToList event,
    Emitter<ClassroomEquipmentState> emit,
  ) {
    //     final Equipment document = Equipment(
    // id: event.equipment.id,
    // description: state.specs.value.isEmpty ? state.selectedSpecs!.description: state.specs.value,
    // category: state.selectedSpecs!.category,
    //   );

    //   final newList = state.globalDocuments;
    //   final ifoIndex = state.globalDocuments
    //       .indexWhere((element) => element.id == document.id);

    //   newList[ifoIndex] = document;
    //   newList.sort((a, b) => a.name.compareTo(b.name));
    //   emit(
    //     state.copyWith(
    //       documentActionStatus: DocumentActionStatus.savedOnGlobal,
    //       globalDocuments: newList,
    //     ),
    //   );
    //   emit(state.copyWith(documentActionStatus: DocumentActionStatus.pure));
  }

  void _onSpecsChanged(
    ClassroomEquipmentSpecsChanged event,
    Emitter<ClassroomEquipmentState> emit,
  ) {
    final specs = Specs.dirty(event.specs);
    emit(
      state.copyWith(
        specs: specs,
        formStatus: Formz.validate([
          specs,
        ]),
      ),
    );
  }

  void _onTypeChanged(
    ClassroomEquipmentTypeChanged event,
    Emitter<ClassroomEquipmentState> emit,
  ) {
    emit(state.copyWith(equipmentBelonging: event.type));
  }

  void _onInventoryNumberChanged(
    ClassroomEquipmentInventoryNumberChanged event,
    Emitter<ClassroomEquipmentState> emit,
  ) {
    final inventoryNumber = InventoryNumber.dirty(event.inventoryNumber);
    emit(
      state.copyWith(
        inventoryNumber: inventoryNumber,
        formStatus: Formz.validate([inventoryNumber]),
      ),
    );
  }

  void _onInternalNumberChanged(
    ClassroomEquipmentInternalNumberChanged event,
    Emitter<ClassroomEquipmentState> emit,
  ) {
    emit(
      state.copyWith(
        internalNumber: event.internalNumber,
        formStatus: Formz.validate([state.inventoryNumber]),
      ),
    );
  }

  Future<void> _onLoadSpecs(
    ClassroomEquipmentLoadSpecs event,
    Emitter<ClassroomEquipmentState> emit,
  ) async {
    emit(
      state.copyWith(
        classroomEquipmentLoadingStatus:
            ClassroomEquipmentLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _classroomEquipmentRepository.allSpecs();
    if (waiting.isNotEmpty) {
      waiting.sort((a, b) => a.id.compareTo(b.id));
    }

    emit(
      state.copyWith(
        globalSpecs: waiting,
        classroomEquipmentLoadingStatus:
            ClassroomEquipmentLoadingStatus.loadingSuccess,
      ),
    );
  }

  // Future<void> _onLoadSpecsByCategory(
  //   ClassroomEquipmentSpecsByCategory event,
  //   Emitter<ClassroomEquipmentState> emit,
  // ) async {
  //   emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
  //   final waiting = await _classroomEquipmentRepository.specsByCategory(
  //     categoryId: state.selectedCategory!.id,
  //   );
  //   if (waiting.isNotEmpty) {
  //     waiting.sort((a, b) => a.id.compareTo(b.id));
  //   }
  //     emit(
  //     state.copyWith(
  //       globalSpecs: waiting,
  //       classroomEquipmentLoadingStatus:
  //           ClassroomEquipmentLoadingStatus.loadingSuccess,
  //     ),
  //   );
  // }

  Future<void> _onSavedSpecs(
    ClassroomEquipmentSpecsSaved event,
    Emitter<ClassroomEquipmentState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    if (state.formStatus.isValidated) {
      final waiting = await _classroomEquipmentRepository.updateEquipmentSpecs(
        UpdateSpecsModelRequest(
          id: state.selectedSpecs!.id,
          description: state.specs.value,
          category: state.selectedCategory!.id,
        ),
      );
      if (waiting == EquipmentStatus.notChanged) {
        emit(
          state.copyWith(
            classroomEquipmentLoadingStatus:
                ClassroomEquipmentLoadingStatus.loadingFailed,
            equipmentActionStatus: EquipmentActionStatus.notSaved,
          ),
        );
        emit(
          state.copyWith(
            equipmentActionStatus: EquipmentActionStatus.pure,
          ),
        );
      } else {
        emit(
          state.copyWith(
            classroomEquipmentLoadingStatus:
                ClassroomEquipmentLoadingStatus.loadingSuccess,
            equipmentActionStatus: EquipmentActionStatus.saved,
          ),
        );
        emit(
          state.copyWith(
            equipmentActionStatus: EquipmentActionStatus.pure,
          ),
        );
      }
    }
  }

  Future<void> _onDeletedSpecs(
    ClassroomEquipmentSpecsDeleted event,
    Emitter<ClassroomEquipmentState> emit,
  ) async {
    emit(
      state.copyWith(
        classroomEquipmentLoadingStatus:
            ClassroomEquipmentLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _classroomEquipmentRepository
        .deleteEquipmentSpecs(state.selectedSpecs!.id);
    if (waiting == EquipmentStatus.deleted) {
      emit(
        state.copyWith(
          classroomEquipmentLoadingStatus:
              ClassroomEquipmentLoadingStatus.loadingSuccess,
          equipmentActionStatus: EquipmentActionStatus.deleted,
        ),
      );
      emit(state.copyWith(equipmentActionStatus: EquipmentActionStatus.pure));
    } else {
      emit(
        state.copyWith(
          classroomEquipmentLoadingStatus:
              ClassroomEquipmentLoadingStatus.loadingFailed,
          equipmentActionStatus: EquipmentActionStatus.notDeleted,
        ),
      );
      emit(state.copyWith(equipmentActionStatus: EquipmentActionStatus.pure));
    }
  }

  Future<void> _onSubmitted(
    ClassroomEquipmentSpecsSubmitted event,
    Emitter<ClassroomEquipmentState> emit,
  ) async {
    print(state.selectedCategory);

    if (state.selectedCategory == null) {
      emit(
        state.copyWith(
          equipmentActionStatus: EquipmentActionStatus.emptyFields,
        ),
      );
      emit(
        state.copyWith(
          equipmentActionStatus: EquipmentActionStatus.pure,
        ),
      );
    } else {
      emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
      if (state.formStatus.isValidated) {
        final waiting =
            await _classroomEquipmentRepository.createEquipmentSpecs(
          CreateSpecsModelRequest(
            category: state.selectedCategory!.id,
            description: state.specs.value,
          ),
        );
        if (waiting == EquipmentStatus.notCreated) {
          emit(
            state.copyWith(
              formStatus: FormzStatus.submissionFailure,
              equipmentActionStatus: EquipmentActionStatus.notAdded,
            ),
          );
          emit(
            state.copyWith(
              equipmentActionStatus: EquipmentActionStatus.pure,
            ),
          );
        } else {
          emit(
            state.copyWith(
              formStatus: FormzStatus.submissionSuccess,
              equipmentActionStatus: EquipmentActionStatus.added,
            ),
          );
          emit(
            state.copyWith(
              equipmentActionStatus: EquipmentActionStatus.pure,
            ),
          );
        }
      }
    }
  }

  Future<void> _onCreated(
    ClassroomEquipmentCreated event,
    Emitter<ClassroomEquipmentState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    if (state.formStatus.isValidated) {
      final waiting = await _classroomEquipmentRepository.createEquipment(
        CreateEquipmentModelRequest(
          inventoryNumber: int.parse(state.inventoryNumber.value),
          classroom: state.selectedClassroom?.number,
          equipment: state.selectedSpecs!.id,
          numberInClassroom: state.internalNumber,
          type: state.equipmentBelonging,
        ),
      );
      if (waiting == EquipmentStatus.notCreated) {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionFailure,
            equipmentActionStatus: EquipmentActionStatus.notAdded,
          ),
        );
        emit(
          state.copyWith(
            equipmentActionStatus: EquipmentActionStatus.pure,
          ),
        );
      } else {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionSuccess,
            equipmentActionStatus: EquipmentActionStatus.added,
          ),
        );
        emit(
          state.copyWith(
            equipmentActionStatus: EquipmentActionStatus.pure,
          ),
        );
      }
    }
  }

  Future<void> _onLoadUserEquipmentList(
    ClassroomEquipmentLoadUserEquipmentsList event,
    Emitter<ClassroomEquipmentState> emit,
  ) async {
    emit(
      state.copyWith(
        classroomEquipmentLoadingStatus:
            ClassroomEquipmentLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _classroomEquipmentRepository.userEquipments();
    if (waiting.isNotEmpty) {
      waiting.sort(
        (a, b) => a.equipment.category.name.compareTo(
          b.equipment.category.name,
        ),
      );
    }
    emit(
      state.copyWith(
        globalEquipments: waiting,
        classroomEquipmentLoadingStatus:
            ClassroomEquipmentLoadingStatus.loadingSuccess,
      ),
    );
  }

  Future<void> _selectedClassroom(
    ClassroomEquipmentSelectedClassroom event,
    Emitter<ClassroomEquipmentState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedClassroom: event.selectedClassroom,
        classroomEquipmentLoadingStatus:
            ClassroomEquipmentLoadingStatus.loadingInProgress,
      ),
    );
    final waiting =
        await _classroomEquipmentRepository.userChosenClassroomEquipment(
      classroom: event.selectedClassroom!.number,
    );
    if (waiting.isNotEmpty) {
      waiting.sort(
        (a, b) => a.equipment.category.name.compareTo(
          b.equipment.category.name,
        ),
      );
    }
    emit(
      state.copyWith(
        globalEquipments: waiting,
        classroomEquipmentLoadingStatus:
            ClassroomEquipmentLoadingStatus.loadingSuccess,
      ),
    );
  }

  void _onFiltered(
    ClassroomEquipmentFilteredEquipment event,
    Emitter<ClassroomEquipmentState> emit,
  ) {
    //print("bloc");
    List<ClassroomEquipment> newList = state.filteredEquipment;
    //print(newList);

    ClassroomEquipment classroomEquipment;

    //print("OK $classroomEquipment");
    //print("1 isChecked ${event.filteredEquipment!.isChecked}");
    if (event.filteredEquipment!.isChecked) {
      classroomEquipment = ClassroomEquipment(
        id: event.filteredEquipment!.id,
        inventoryNumber: event.filteredEquipment!.inventoryNumber,
        classroom: event.filteredEquipment!.classroom,
        equipment: event.filteredEquipment!.equipment,
        numberInClassroom: event.filteredEquipment!.numberInClassroom,
        equipmentType: event.filteredEquipment!.equipmentType,
        isChecked: event.filteredEquipment!.isChecked,
      );
      //print("CHECKED $classroomEquipment");
      newList = List.from(state.filteredEquipment)..add(classroomEquipment);
      // print("true");
      // print(newList);
      // print("2 isChecked ${event.filteredEquipment!.isChecked}");
      emit(state.copyWith(filteredEquipment: newList));
    }
    if (event.filteredEquipment!.isChecked == false) {
      classroomEquipment = ClassroomEquipment(
        id: event.filteredEquipment!.id,
        inventoryNumber: event.filteredEquipment!.inventoryNumber,
        classroom: event.filteredEquipment!.classroom,
        equipment: event.filteredEquipment!.equipment,
        numberInClassroom: event.filteredEquipment!.numberInClassroom,
        equipmentType: event.filteredEquipment!.equipmentType,
        isChecked: event.filteredEquipment!.isChecked,
      );

      final index = state.filteredEquipment.indexWhere((element) {
        //  print("element.inventoryNumber ${element.inventoryNumber}");
        return element.inventoryNumber == classroomEquipment.inventoryNumber;
      });
      newList[index] = classroomEquipment;
      emit(state.copyWith(filteredEquipment: newList));
      //print("3 $newList");

      newList.removeWhere((item) {
        // print("item");
        // print(item);
        return item.isChecked == false &&
            item.inventoryNumber == event.filteredEquipment!.inventoryNumber;
      });
      //  print("4 $newList");
      emit(state.copyWith(filteredEquipment: newList));
    }
  }

  void _onSelected(
    ClassroomEquipmentUserSelected event,
    Emitter<ClassroomEquipmentState> emit,
  ) {
    emit(state.copyWith(selectedEquipment: event.selectedEquipment));
  }

  void _onSearch(
    ClassroomEquipmentSearch event,
    Emitter<ClassroomEquipmentState> emit,
  ) {
    List<ClassroomEquipment> finalList = [];
    if (event.matchingWord.isNotEmpty) {
      finalList = state.globalEquipments
          .where(
            (equipment) => equipment.inventoryNumber.toString().contains(
                  event.matchingWord,
                ),
          )
          .toList();
    }
    emit(
      state.copyWith(
        visibleList: finalList,
        searchText: event.matchingWord,
      ),
    );
  }
}

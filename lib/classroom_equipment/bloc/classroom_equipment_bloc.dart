import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment.dart';
import 'package:ptk_inventory/classroom_equipment/repository/classroom_equipment_repository.dart';

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
  }

  final ClassroomEquipmentRepository _classroomEquipmentRepository;

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

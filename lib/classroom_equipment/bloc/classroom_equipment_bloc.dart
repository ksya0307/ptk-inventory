import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment.dart';
import 'package:ptk_inventory/classroom_equipment/repository/classroom_equipment_repository.dart';

part 'classroom_equipment_event.dart';
part 'classroom_equipment_state.dart';

class ClassroomEquipmentBloc
    extends Bloc<ClassroomEquipmentEvent, ClassroomEquipmentState> {
  ClassroomEquipmentBloc(
      {required ClassroomEquipmentRepository classroomEquipmentRepository})
      : _classroomEquipmentRepository = classroomEquipmentRepository,
        super(const ClassroomEquipmentState()) {
    on<ClassroomEquipmentLoadUserEquipmentsList>(_onLoadUserEquipmentList);
    on<ClassroomEquipmentSearch>(_onSearch);
    on<ClassroomEquipmentUserSelected>(_onSelected);
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
      waiting
          .sort((a, b) => a.numberInClassroom.compareTo(b.numberInClassroom));
    }
    emit(
      state.copyWith(
        globalEquipments: waiting,
        classroomEquipmentLoadingStatus:
            ClassroomEquipmentLoadingStatus.loadingSuccess,
      ),
    );
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

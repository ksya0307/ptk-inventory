import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment.dart';
import 'package:ptk_inventory/classrooms/model/classroom.dart';
import 'package:ptk_inventory/common/model/user.dart';
import 'package:ptk_inventory/documents/model/document.dart';
import 'package:ptk_inventory/ifo/model/ifo.dart';
import 'package:ptk_inventory/inventory/model/inventory.dart';
import 'package:ptk_inventory/inventory/model/requests/create_comment_request.dart';
import 'package:ptk_inventory/inventory/model/requests/create_inventory_request.dart';
import 'package:ptk_inventory/inventory/repository/inventory_repository.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc({required InventoryRepository inventoryRepository})
      : _inventoryRepository = inventoryRepository,
        super(InventoryState()) {
    on<InventoryLoadList>(_onLoadList);
    on<InventorySubmitted>(_onSubmitted);
    on<InventoryEquipmentSelected>(_onEquipmentSelected);
    on<InventoryClassroomSelected>(_onClassroomSelected);
    on<InventoryDateSelected>(_onDateChanged);
    on<InventoryDocumentSelected>(_onDocSelected);
    on<InventoryIfoSelected>(_onIfoSelected);
    on<InventoryGivenChanged>(_onGivenChanged);
    on<InventoryByRequestChanged>(_onRequestChanged);
    on<InventoryCommentChanged>(_onCommentChanged);
    on<InventorySearch>(_onSearch);
  }

  final InventoryRepository _inventoryRepository;

  void _onSearch(
    InventorySearch event,
    Emitter<InventoryState> emit,
  ) {
    List<Inventory> finalList = [];
    if (event.matchingWord.isNotEmpty) {
      finalList = state.globalInventory
          .where(
            (element) =>
                element.inventoryNumber.inventoryNumber.toString().contains(
                      event.matchingWord,
                    ),
          )
          .toList();
    }
    emit(
      state.copyWith(visibleList: finalList, searchText: event.matchingWord),
    );
  }

  Future<void> _onLoadList(
    InventoryLoadList event,
    Emitter<InventoryState> emit,
  ) async {
    emit(
      state.copyWith(
        inventoryLoadingStatus: InventoryLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _inventoryRepository.inventory();
    if (waiting.isNotEmpty) {
      waiting.sort((a, b) => a.getDate.compareTo(b.getDate));
    }
    emit(
      state.copyWith(
        globalInventory: waiting,
        inventoryLoadingStatus: InventoryLoadingStatus.loadingSuccess,
      ),
    );
  }

  void _onEquipmentSelected(
    InventoryEquipmentSelected event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(selectedEquipment: event.selectedEquipment));
    print(state.selectedEquipment);
  }

  void _onClassroomSelected(
    InventoryClassroomSelected event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(selectedClassroom: event.selectedClassroom));
  }

  void _onCommentChanged(
    InventoryCommentChanged event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(comment: event.comment));
  }

  void _onRequestChanged(
    InventoryByRequestChanged event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(byRequest: event.byRequest));
  }

  void _onGivenChanged(
    InventoryGivenChanged event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(given: event.given));
  }

  void _onIfoSelected(
    InventoryIfoSelected event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(selectedIfo: event.selectedIfo));
    print(state.selectedIfo);
  }

  void _onDocSelected(
    InventoryDocumentSelected event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(selectedDocument: event.selectedDocument));
    print(state.selectedDocument);
  }

  void _onDateChanged(
    InventoryDateSelected event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(getDate: event.dateTime));
    print(state.getDate);
  }

  Future<void> _onSubmitted(
    InventorySubmitted event,
    Emitter<InventoryState> emit,
  ) async {
    emit(
      state.copyWith(
        formStatus: FormzStatus.submissionInProgress,
      ),
    );
    final inventory = await _inventoryRepository.createInventory(
      createInventoryModelRequest: CreateInventoryModelRequest(
        inventoryNumber: state.selectedEquipment!.id,
        getDate: state.getDate!,
        document: state.selectedDocument!.id,
        ifo: state.selectedIfo!.id,
        forClassroom: state.selectedClassroom!.number,
        given: state.given,
        byRequest: state.byRequest,
      ),
    );
    if (inventory != null) {
      emit(state.copyWith(inventory: inventory));
      emit(
        state.copyWith(
          formStatus: FormzStatus.submissionSuccess,
          inventoryActionStatus: InventoryActionStatus.added,
        ),
      );
      emit(
        state.copyWith(
          inventoryActionStatus: InventoryActionStatus.pure,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormzStatus.submissionFailure,
          inventoryActionStatus: InventoryActionStatus.notAdded,
        ),
      );
      emit(
        state.copyWith(
          inventoryActionStatus: InventoryActionStatus.pure,
        ),
      );
      print(state.comment);
      if (state.comment != null) {
        final waiting = await _inventoryRepository.createComment(
          createCommentModelRequest: CreateCommentModelRequest(
            comment: state.comment!,
            inventoryId: state.inventory!.id,
            userId: event.user.id,
            datetime: state.getDate!,
          ),
        );

        if (waiting == InventoryStatus.notCreated) {
          emit(
            state.copyWith(
              formStatus: FormzStatus.submissionFailure,
              inventoryActionStatus: InventoryActionStatus.notAdded,
            ),
          );
          emit(
            state.copyWith(
              inventoryActionStatus: InventoryActionStatus.pure,
            ),
          );
        } else {
          emit(
            state.copyWith(
              formStatus: FormzStatus.submissionSuccess,
              inventoryActionStatus: InventoryActionStatus.added,
            ),
          );
          emit(
            state.copyWith(
              inventoryActionStatus: InventoryActionStatus.pure,
            ),
          );
        }
      }
    }
  }
}

part of 'inventory_bloc.dart';

class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class InventorySubmitted extends InventoryEvent {
  final User user;
  const InventorySubmitted(this.user);
}

//equipment Selected
class InventoryEquipmentSelected extends InventoryEvent {
  final ClassroomEquipment? selectedEquipment;
  const InventoryEquipmentSelected(
    this.selectedEquipment,
  );
}

//classroom Selected
class InventoryClassroomSelected extends InventoryEvent {
  final Classroom? selectedClassroom;

  const InventoryClassroomSelected(this.selectedClassroom);
}

class InventoryLoadList extends InventoryEvent {
  const InventoryLoadList();
}

//Date selected
class InventoryDateSelected extends InventoryEvent {
  final DateTime? dateTime;
  const InventoryDateSelected({
    this.dateTime,
  });
}

//document Selected
class InventoryDocumentSelected extends InventoryEvent {
  final Document? selectedDocument;
  const InventoryDocumentSelected({
    this.selectedDocument,
  });
}

//ifo selected
class InventoryIfoSelected extends InventoryEvent {
  final Ifo? selectedIfo;
  const InventoryIfoSelected({this.selectedIfo});
}

//given
class InventoryGivenChanged extends InventoryEvent {
  final bool? given;
  const InventoryGivenChanged({
    this.given,
  });
}

//by request
class InventoryByRequestChanged extends InventoryEvent {
  final bool? byRequest;
  const InventoryByRequestChanged({
    this.byRequest,
  });
}

//comment changed
class InventoryCommentChanged extends InventoryEvent {
  final String? comment;
  const InventoryCommentChanged({
    this.comment,
  });
}

//search
class InventorySearch extends InventoryEvent {
  final String matchingWord;

  const InventorySearch({required this.matchingWord});

  @override
  List<Object> get props => [matchingWord];
}

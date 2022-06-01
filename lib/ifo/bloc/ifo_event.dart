part of 'ifo_bloc.dart';

abstract class IfoEvent extends Equatable {
  const IfoEvent();

  @override
  List<Object> get props => [];
}

class IfoNameChanged extends IfoEvent {
  final String name;

  const IfoNameChanged(this.name);
  @override
  List<Object> get props => [name];
}

class IfoLoadList extends IfoEvent {
  const IfoLoadList();
}

class IfoSubmitted extends IfoEvent {
  const IfoSubmitted();
}

class IfoSaved extends IfoEvent {
  const IfoSaved();
}

class IfoSearch extends IfoEvent {
  const IfoSearch({
    required this.matchingWord,
  });
  final String matchingWord;
}

class IfoDeleted extends IfoEvent {
  final int id;
  const IfoDeleted(this.id);
  @override
  List<Object> get props => [id];
}

class IfoSelected extends IfoEvent {
  final Ifo? selectedIfo;

  const IfoSelected(this.selectedIfo);
}

class IfoDeleteFromList extends IfoEvent {
  final Ifo ifo;
  const IfoDeleteFromList({required this.ifo});
  @override
  List<Object> get props => [ifo];
}

class IfoAddToList extends IfoEvent {
  final Ifo ifo;
  const IfoAddToList({required this.ifo});
  @override
  List<Object> get props => [ifo];
}

class IfoSaveToList extends IfoEvent {
  final Ifo ifo;
  const IfoSaveToList({required this.ifo});
  @override
  List<Object> get props => [ifo];
}

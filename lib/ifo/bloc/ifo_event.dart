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
  const IfoDeleted();
}

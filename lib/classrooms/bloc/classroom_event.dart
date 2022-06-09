part of 'classroom_bloc.dart';

abstract class ClassroomEvent extends Equatable {
  const ClassroomEvent();

  @override
  List<Object> get props => [];
}

class ClassroomNumberChanged extends ClassroomEvent {
  final String number;

  const ClassroomNumberChanged(this.number);
  @override
  List<Object> get props => [number];
}

class ClassroomLoadList extends ClassroomEvent {
  const ClassroomLoadList();
}

class ClassroomLoadUserList extends ClassroomEvent {
  final int userId;

  const ClassroomLoadUserList(this.userId);
}

class ClassroomSubmitted extends ClassroomEvent {
  const ClassroomSubmitted();
}

class ClassroomSaved extends ClassroomEvent {
  const ClassroomSaved();
}

class ClassroomSearch extends ClassroomEvent {
  final String matchingWord;
  const ClassroomSearch({
    required this.matchingWord,
  });

  @override
  List<Object> get props => [matchingWord];
}

class ClassroomDeleted extends ClassroomEvent {
  final String number;
  const ClassroomDeleted(this.number);
  @override
  List<Object> get props => [number];
}

class ClassroomSelected extends ClassroomEvent {
  final Classroom? selectedClassroom;

  const ClassroomSelected(this.selectedClassroom);
}

class ClassroomDeleteFromList extends ClassroomEvent {
  final Classroom classroom;
  const ClassroomDeleteFromList({required this.classroom});
  @override
  List<Object> get props => [classroom];
}

class ClassroomAddToList extends ClassroomEvent {
  final Classroom classroom;
  const ClassroomAddToList({required this.classroom});
  @override
  List<Object> get props => [classroom];
}

class ClassroomSaveToList extends ClassroomEvent {
  final Classroom classroom;
  const ClassroomSaveToList({required this.classroom});
  @override
  List<Object> get props => [classroom];
}

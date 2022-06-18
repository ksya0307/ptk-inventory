part of 'classroom_bloc.dart';

enum ClassroomLoadingStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}

enum ClassroomActionStatus {
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

class ClassroomState extends Equatable {
  final FormzStatus formStatus;
  final Number number;
  final User user;
  final String searchText;
  final Classroom? selectedClassroom;
  final ClassroomLoadingStatus classroomLoadingStatus;
  final List<Classroom> globalClassrooms;
  final List<Classroom> visibleList;
  final ClassroomActionStatus classroomActionStatus;

  const ClassroomState({
    this.formStatus = FormzStatus.pure,
    this.number = const Number.pure(),
    this.searchText = "",
    this.selectedClassroom,
    this.classroomLoadingStatus = ClassroomLoadingStatus.pure,
    this.globalClassrooms = const [],
    this.visibleList = const [],
    this.classroomActionStatus = ClassroomActionStatus.pure,
    this.user = User.empty,
  });

  @override
  List<Object?> get props {
    return [
      formStatus,
      number,
      searchText,
      selectedClassroom,
      classroomLoadingStatus,
      globalClassrooms,
      visibleList,
      classroomActionStatus,
      user
    ];
  }

  ClassroomState copyWith({
    FormzStatus? formStatus,
    Number? number,
    User? user,
    String? searchText,
    Classroom? selectedClassroom,
    ClassroomLoadingStatus? classroomLoadingStatus,
    List<Classroom>? globalClassrooms,
    List<Classroom>? visibleList,
    ClassroomActionStatus? classroomActionStatus,
  }) {
    print("classroom loading");
    print(classroomLoadingStatus);
    return ClassroomState(
      formStatus: formStatus ?? this.formStatus,
      number: number ?? this.number,
      user: user ?? this.user,
      searchText: searchText ?? this.searchText,
      selectedClassroom: selectedClassroom ?? this.selectedClassroom,
      classroomLoadingStatus:
          classroomLoadingStatus ?? this.classroomLoadingStatus,
      globalClassrooms: globalClassrooms ?? this.globalClassrooms,
      visibleList: visibleList ?? this.visibleList,
      classroomActionStatus:
          classroomActionStatus ?? this.classroomActionStatus,
    );
  }
}

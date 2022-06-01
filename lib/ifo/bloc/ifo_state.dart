part of 'ifo_bloc.dart';

enum IfoLoadingStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}

enum IfoActionStatus {
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

class IfoState extends Equatable {
  final FormzStatus formStatus;
  final Name name;
  final IfoLoadingStatus ifoLoadingStatus;
  final IfoActionStatus ifoActionStatus;
  final Ifo? selectedIfo;
  final List<Ifo> globalIfos;
  final List<Ifo> visibleList;
  final String searchText;
  const IfoState({
    this.formStatus = FormzStatus.pure,
    this.name = const Name.pure(),
    this.ifoLoadingStatus = IfoLoadingStatus.pure,
    this.ifoActionStatus = IfoActionStatus.pure,
    this.selectedIfo,
    this.globalIfos = const [],
    this.visibleList = const [],
    this.searchText = "",
  });

  @override
  List<Object?> get props {
    return [
      formStatus,
      name,
      ifoLoadingStatus,
      ifoActionStatus,
      selectedIfo,
      globalIfos,
      visibleList,
      searchText
    ];
  }

  IfoState copyWith({
    FormzStatus? formStatus,
    Name? name,
    IfoLoadingStatus? ifoLoadingStatus,
    IfoActionStatus? ifoActionStatus,
    Ifo? selectedIfo,
    List<Ifo>? globalIfos,
    List<Ifo>? visibleList,
    String? searchText,
  }) {
    return IfoState(
      formStatus: formStatus ?? this.formStatus,
      name: name ?? this.name,
      ifoLoadingStatus: ifoLoadingStatus ?? this.ifoLoadingStatus,
      ifoActionStatus: ifoActionStatus ?? this.ifoActionStatus,
      selectedIfo: selectedIfo ?? this.selectedIfo,
      globalIfos: globalIfos ?? this.globalIfos,
      visibleList: visibleList ?? this.visibleList,
      searchText: searchText ?? this.searchText,
    );
  }
}

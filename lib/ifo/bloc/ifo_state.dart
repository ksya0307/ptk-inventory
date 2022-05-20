part of 'ifo_bloc.dart';

enum IfoLoadingStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}

class IfoState extends Equatable {
  final FormzStatus formStatus;
  final Name name;
  final IfoLoadingStatus ifoLoadingStatus;
  final Ifo? selectedIfo;
  final List<Ifo> globalIfos;
  final List<Ifo> visibleList;
  const IfoState({
    this.formStatus = FormzStatus.pure,
    this.name = const Name.pure(),
    this.ifoLoadingStatus = IfoLoadingStatus.pure,
    this.selectedIfo,
    this.globalIfos = const [],
    this.visibleList = const [],
  });

  IfoState copyWith({
    FormzStatus? formStatus,
    Name? name,
    IfoLoadingStatus? ifoLoadingStatus,
    Ifo? selectedIfo,
    List<Ifo>? globalIfos,
    List<Ifo>? visibleList,
  }) {
    return IfoState(
      formStatus: formStatus ?? this.formStatus,
      name: name ?? this.name,
      ifoLoadingStatus: ifoLoadingStatus ?? this.ifoLoadingStatus,
      selectedIfo: selectedIfo ?? this.selectedIfo,
      globalIfos: globalIfos ?? this.globalIfos,
      visibleList: visibleList ?? this.visibleList,
    );
  }

  @override
  List<Object?> get props {
    return [
      formStatus,
      name,
      ifoLoadingStatus,
      selectedIfo,
      globalIfos,
      visibleList,
    ];
  }
}

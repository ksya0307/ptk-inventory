import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ifo_event.dart';
part 'ifo_state.dart';

class IfoBloc extends Bloc<IfoEvent, IfoState> {
  IfoBloc() : super(IfoInitial()) {
    on<IfoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

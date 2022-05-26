import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'repair_event.dart';
part 'repair_state.dart';

class RepairBloc extends Bloc<RepairEvent, RepairState> {
  RepairBloc() : super(RepairInitial()) {
    on<RepairEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

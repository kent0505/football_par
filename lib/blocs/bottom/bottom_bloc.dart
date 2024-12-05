import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_event.dart';
part 'bottom_state.dart';

class BottomBloc extends Bloc<BottomEvent, BottomState> {
  BottomBloc() : super(BottomInitial()) {
    on<ChangeBottom>(_changePage);
  }

  void _changePage(
    ChangeBottom event,
    Emitter<BottomState> emit,
  ) {
    if (event.id == 1) emit(BottomInitial());
    if (event.id == 2) emit(BottomNews());
    if (event.id == 3) emit(BottomQuiz());
    if (event.id == 4) emit(BottomPuzzle());
    if (event.id == 5) emit(BottomSettings());
  }
}

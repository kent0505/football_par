import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/utils.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<GameEvent>(
      (event, emit) => switch (event) {
        LoadData() => _loadData(event, emit),
        GetGames() => _getGames(event, emit),
      },
    );
  }

  void _loadData(
    LoadData event,
    Emitter<GameState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    bool onboard = prefs.getBool('onboard') ?? true;
    logger(onboard);
    emit(DataLoaded(onboard: onboard));
  }

  void _getGames(
    GetGames event,
    Emitter<GameState> emit,
  ) async {}
}

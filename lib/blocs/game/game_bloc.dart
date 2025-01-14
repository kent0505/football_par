import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/game_api.dart';
import '../../models/game.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final _gameApi = GameApi();

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
    bool onboard = prefs.getBool('onboard') ?? true;
    emit(DataLoaded(onboard: onboard));
  }

  void _getGames(
    GetGames event,
    Emitter<GameState> emit,
  ) async {
    emit(GamesLoading());
    try {
      List<Game> games = await _gameApi.getGames();
      emit(GamesLoaded(games: games));
    } on Object catch (_) {
      emit(GamesLoaded(games: const []));
    }
  }
}

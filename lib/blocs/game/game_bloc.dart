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
        GetStats() => _getStats(event, emit),
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
    emit(DataLoaded(onboard: onboard));
  }

  void _getGames(
    GetGames event,
    Emitter<GameState> emit,
  ) async {
    emit(GamesLoading());
    final prefs = await SharedPreferences.getInstance();
    int lastLoadDay = prefs.getInt('lastLoadDay') ?? 0;
    String jsonData = prefs.getString('jsonData') ?? '';

    if (lastLoadDay == DateTime.now().day && jsonData.isNotEmpty) {
      try {
        List<Game> games = await _gameApi.getJson(jsonData);
        emit(GamesLoaded(
          games: games,
          goals: const [],
          stats: statsDefault,
        ));
      } on Object catch (_) {}
    } else {
      try {
        List<Game> games = await _gameApi.getGames();
        emit(GamesLoaded(
          games: games,
          goals: const [],
          stats: statsDefault,
        ));
      } on Object catch (_) {}
    }
  }

  void _getStats(
    GetStats event,
    Emitter<GameState> emit,
  ) async {
    try {
      Stats stats = await _gameApi.fetchStats(event.id);
      List<Goal> goals = await _gameApi.fetchGoals(event.id);
      emit(GamesLoaded(
        games: event.games,
        stats: stats,
        goals: goals,
      ));
    } on Object catch (_) {}
  }
}

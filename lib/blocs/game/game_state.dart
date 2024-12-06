part of 'game_bloc.dart';

@immutable
sealed class GameState {}

final class GameInitial extends GameState {}

final class GamesLoading extends GameState {}

final class GamesLoaded extends GameState {
  GamesLoaded({
    required this.games,
    required this.stats,
    required this.goals,
  });

  final List<Game> games;
  final Stats stats;
  final List<Goal> goals;
}

final class DataLoaded extends GameState {
  DataLoaded({required this.onboard});

  final bool onboard;
}

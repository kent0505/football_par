part of 'game_bloc.dart';

@immutable
sealed class GameState {}

final class GameInitial extends GameState {}

final class GamesLoading extends GameState {}

final class GamesLoaded extends GameState {
  GamesLoaded({required this.games, this.stats});

  final List<Game> games;
  final Stats? stats;
}

final class DataLoaded extends GameState {
  DataLoaded({required this.onboard});

  final bool onboard;
}

final class GamesError extends GameState {}

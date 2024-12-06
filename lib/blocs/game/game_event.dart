part of 'game_bloc.dart';

@immutable
sealed class GameEvent {}

class LoadData extends GameEvent {}

class GetGames extends GameEvent {}

class GetStats extends GameEvent {
  GetStats({required this.id, required this.games});

  final int id;
  final List<Game> games;
}

part of 'game_bloc.dart';

@immutable
sealed class GameEvent {}

class LoadData extends GameEvent {}

class GetGames extends GameEvent {}

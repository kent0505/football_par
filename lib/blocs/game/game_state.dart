part of 'game_bloc.dart';

@immutable
sealed class GameState {}

final class GameInitial extends GameState {}

final class GameLoading extends GameState {}

final class GameLoaded extends GameState {}

final class DataLoaded extends GameState {
  DataLoaded({required this.onboard});

  final bool onboard;
}

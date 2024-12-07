part of 'detail_bloc.dart';

@immutable
sealed class DetailState {}

final class DetailInitial extends DetailState {}

final class DetailsLoading extends DetailState {}

final class DetailsLoaded extends DetailState {
  DetailsLoaded({
    required this.lineup,
    required this.stats,
    required this.goals,
  });

  final Lineup lineup;
  final Stats stats;
  final List<Goal> goals;
}

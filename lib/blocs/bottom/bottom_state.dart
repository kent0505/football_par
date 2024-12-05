part of 'bottom_bloc.dart';

@immutable
sealed class BottomState {}

final class BottomInitial extends BottomState {}

final class BottomNews extends BottomState {}

final class BottomQuiz extends BottomState {}

final class BottomPuzzle extends BottomState {}

final class BottomSettings extends BottomState {}

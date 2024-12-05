part of 'bottom_bloc.dart';

@immutable
sealed class BottomEvent {}

class ChangeBottom extends BottomEvent {
  ChangeBottom({required this.id});

  final int id;
}

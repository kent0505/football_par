part of 'detail_bloc.dart';

@immutable
sealed class DetailEvent {}

class GetDetails extends DetailEvent {
  GetDetails({required this.fixture});

  final int fixture;
}

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/game_api.dart';
import '../../models/game.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final _gameApi = GameApi();

  DetailBloc() : super(DetailInitial()) {
    on<GetDetails>(_getDetails);
  }

  void _getDetails(
    GetDetails event,
    Emitter<DetailState> emit,
  ) async {
    try {
      emit(DetailsLoading());
      Lineup lineup = await _gameApi.fetchLineups(event.fixture);
      Stats stats = await _gameApi.fetchStats(event.fixture);
      List<Goal> goals = await _gameApi.fetchGoals(event.fixture);
      emit(DetailsLoaded(
        stats: stats,
        lineup: lineup,
        goals: goals,
      ));
    } on Object catch (_) {}
  }
}

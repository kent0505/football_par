import '../utils/utils.dart';

class Game {
  const Game({
    required this.id,
    required this.league,
    required this.title1,
    required this.title2,
    required this.logo1,
    required this.logo2,
    required this.goals1,
    required this.goals2,
    required this.stadium,
    required this.date,
  });

  final int id;
  final String league;
  final String title1;
  final String title2;
  final String logo1;
  final String logo2;
  final int goals1;
  final int goals2;
  final String stadium;
  final int date;

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['fixture']['id'],
      league: json['league']['name'],
      title1: json['teams']['home']['name'],
      title2: json['teams']['away']['name'],
      logo1: json['teams']['home']['logo'],
      logo2: json['teams']['away']['logo'],
      goals1: json['goals']['home'] ?? 0,
      goals2: json['goals']['away'] ?? 0,
      stadium: json['fixture']['venue']['name'] ?? 'null',
      date: json['fixture']['timestamp'] ?? getTimestamp(),
    );
  }
}

class Stats {
  Stats({
    required this.team1,
    required this.team2,
  });

  final Team team1;
  final Team team2;

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      team1: Team.fromJson(json['response'][0]['statistics']),
      team2: Team.fromJson(json['response'][1]['statistics']),
    );
  }
}

class Team {
  Team({
    required this.shots,
    required this.shotsOnGoal,
    required this.possession,
    required this.passes,
    required this.passesAccuracy,
    required this.fouls,
    required this.yellowCards,
    required this.redCards,
    required this.offsides,
    required this.corners,
  });

  final int shots;
  final int shotsOnGoal;
  final String possession;
  final int passes;
  final String passesAccuracy;
  final int fouls;
  final int yellowCards;
  final int redCards;
  final int offsides;
  final int corners;

  factory Team.fromJson(List<dynamic> statistics) {
    return Team(
      shots: statistics[2]['value'] ?? 0,
      shotsOnGoal: statistics[0]['value'] ?? 0,
      possession: statistics[9]['value'] ?? '0%',
      passes: statistics[13]['value'] ?? 0,
      passesAccuracy: statistics[15]['value'] ?? '0%',
      fouls: statistics[6]['value'] ?? 0,
      yellowCards: statistics[10]['value'] ?? 0,
      redCards: statistics[11]['value'] ?? 0,
      offsides: statistics[8]['value'] ?? 0,
      corners: statistics[7]['value'] ?? 0,
    );
  }
}

class Goal {
  Goal({
    required this.player,
    required this.type,
    required this.time,
  });

  final String player;
  final String type;
  final int time;

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      player: json['player']['name'] ?? '',
      type: json['type'] ?? '',
      time: json['time']['elapsed'] ?? '',
    );
  }
}

final statsDefault = Stats(
  team1: Team(
    shots: 0,
    shotsOnGoal: 0,
    possession: '',
    passes: 0,
    passesAccuracy: '',
    fouls: 0,
    yellowCards: 0,
    redCards: 0,
    offsides: 0,
    corners: 0,
  ),
  team2: Team(
    shots: 0,
    shotsOnGoal: 0,
    possession: '',
    passes: 0,
    passesAccuracy: '',
    fouls: 0,
    yellowCards: 0,
    redCards: 0,
    offsides: 0,
    corners: 0,
  ),
);

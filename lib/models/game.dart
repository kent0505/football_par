class Game {
  const Game({
    required this.id,
    required this.score,
    required this.stadium,
    required this.title1,
    required this.title2,
    required this.logo1,
    required this.logo2,
  });

  final int id;
  final String score;
  final String stadium;
  final String title1;
  final String title2;
  final String logo1;
  final String logo2;

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      score: json['score'],
      stadium: json['stadium'],
      title1: json['home']['title'],
      title2: json['away']['title'],
      logo1: json['home']['logo'],
      logo2: json['away']['logo'],
    );
  }
}

class Stats {
  Stats({
    required this.title,
    required this.team1,
    required this.team2,
  });

  final String title;
  final String team1;
  final String team2;

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      title: json['title'],
      team1: json['team1'],
      team2: json['team2'],
    );
  }
}

class Goal {
  Goal({
    required this.player,
    required this.time,
  });

  final String player;
  final String time;

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      player: json['player'],
      time: json['time'],
    );
  }
}

class Lineup {
  Lineup({
    required this.players1,
    required this.players2,
  });

  final List<Player> players1;
  final List<Player> players2;

  factory Lineup.fromJson(Map<String, dynamic> json) {
    final lineup1 = json['lineups'][0];
    final lineup2 = json['lineups'][1];

    return Lineup(
      players1: (lineup1['players'] as List)
          .map((playerJson) => Player.fromJson(playerJson))
          .toList(),
      players2: (lineup2['players'] as List)
          .map((playerJson) => Player.fromJson(playerJson))
          .toList(),
    );
  }

  // factory Lineup.fromJson(Map<String, dynamic> json) {
  //   return Lineup(
  //     formation1: json['lineups'][0]['formation'],
  //     formation2: json['lineups'][1]['formation'],
  //     players1: json['lineups'][0]['players'],
  //     players2: json['lineups'][1]['players'],
  //   );
  // }
}

class Player {
  final String name;
  final String number;
  final String position;

  Player({required this.name, required this.number, required this.position});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      number: json['number'],
      position: json['position'],
    );
  }
}

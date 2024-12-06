class Question {
  Question({required this.title, required this.answers});

  final String title;
  final List<Answer> answers;
}

class Answer {
  Answer({required this.title, required this.isCorrect});

  final String title;
  final bool isCorrect;
}

List<Question> questions = [
  Question(title: 'Who won the FIFA World Cup in 2018?', answers: [
    Answer(title: 'France', isCorrect: true),
    Answer(title: 'Brazil', isCorrect: false),
    Answer(title: 'Germany', isCorrect: false),
    Answer(title: 'Argentina', isCorrect: false),
  ]),
  Question(
      title: 'Which footballer has won the most Ballon d\'Or awards?',
      answers: [
        Answer(title: 'Lionel Messi', isCorrect: true),
        Answer(title: 'Cristiano Ronaldo', isCorrect: false),
        Answer(title: 'Zinedine Zidane', isCorrect: false),
        Answer(title: 'Johan Cruyff', isCorrect: false),
      ]),
  Question(
      title: 'Which club has won the most UEFA Champions League titles?',
      answers: [
        Answer(title: 'Real Madrid', isCorrect: true),
        Answer(title: 'AC Milan', isCorrect: false),
        Answer(title: 'Liverpool', isCorrect: false),
        Answer(title: 'Barcelona', isCorrect: false),
      ]),
  Question(
      title: 'Which country is known as "The Land of Football"?',
      answers: [
        Answer(title: 'Brazil', isCorrect: true),
        Answer(title: 'Spain', isCorrect: false),
        Answer(title: 'England', isCorrect: false),
        Answer(title: 'Italy', isCorrect: false),
      ]),
  Question(title: 'Which player scored the "Hand of God" goal?', answers: [
    Answer(title: 'Diego Maradona', isCorrect: true),
    Answer(title: 'Pelé', isCorrect: false),
    Answer(title: 'Michel Platini', isCorrect: false),
    Answer(title: 'Zico', isCorrect: false),
  ]),
  Question(title: 'In which year was the first FIFA World Cup held?', answers: [
    Answer(title: '1930', isCorrect: true),
    Answer(title: '1928', isCorrect: false),
    Answer(title: '1934', isCorrect: false),
    Answer(title: '1942', isCorrect: false),
  ]),
  Question(
      title: 'Which football club is nicknamed "The Red Devils"?',
      answers: [
        Answer(title: 'Manchester United', isCorrect: true),
        Answer(title: 'Liverpool', isCorrect: false),
        Answer(title: 'Bayern Munich', isCorrect: false),
        Answer(title: 'Arsenal', isCorrect: false),
      ]),
  Question(
      title:
          'Who holds the record for the fastest hat-trick in Premier League history?',
      answers: [
        Answer(title: 'Sadio Mané', isCorrect: true),
        Answer(title: 'Alan Shearer', isCorrect: false),
        Answer(title: 'Cristiano Ronaldo', isCorrect: false),
        Answer(title: 'Thierry Henry', isCorrect: false),
      ]),
  Question(title: 'Which country hosted the 2014 FIFA World Cup?', answers: [
    Answer(title: 'Brazil', isCorrect: true),
    Answer(title: 'Germany', isCorrect: false),
    Answer(title: 'South Africa', isCorrect: false),
    Answer(title: 'Russia', isCorrect: false),
  ]),
  Question(title: 'Which club is known as "The Old Lady"?', answers: [
    Answer(title: 'Juventus', isCorrect: true),
    Answer(title: 'AC Milan', isCorrect: false),
    Answer(title: 'Inter Milan', isCorrect: false),
    Answer(title: 'Napoli', isCorrect: false),
  ]),
  Question(title: 'Who scored the most goals in a single World Cup?', answers: [
    Answer(title: 'Just Fontaine', isCorrect: true),
    Answer(title: 'Gerd Müller', isCorrect: false),
    Answer(title: 'Ronaldo', isCorrect: false),
    Answer(title: 'Miroslav Klose', isCorrect: false),
  ]),
  Question(title: 'Which country has won the most FIFA World Cups?', answers: [
    Answer(title: 'Brazil', isCorrect: true),
    Answer(title: 'Germany', isCorrect: false),
    Answer(title: 'Italy', isCorrect: false),
    Answer(title: 'Argentina', isCorrect: false),
  ]),
  Question(
      title: 'What is the name of the stadium where Liverpool plays?',
      answers: [
        Answer(title: 'Anfield', isCorrect: true),
        Answer(title: 'Old Trafford', isCorrect: false),
        Answer(title: 'Stamford Bridge', isCorrect: false),
        Answer(title: 'Etihad Stadium', isCorrect: false),
      ]),
  Question(
      title:
          'Which player scored the winning goal in the 2010 FIFA World Cup Final?',
      answers: [
        Answer(title: 'Andrés Iniesta', isCorrect: true),
        Answer(title: 'Xavi', isCorrect: false),
        Answer(title: 'David Villa', isCorrect: false),
        Answer(title: 'Fernando Torres', isCorrect: false),
      ]),
  Question(
      title:
          'Which club did David Beckham play for before joining Real Madrid?',
      answers: [
        Answer(title: 'Manchester United', isCorrect: true),
        Answer(title: 'AC Milan', isCorrect: false),
        Answer(title: 'PSG', isCorrect: false),
        Answer(title: 'LA Galaxy', isCorrect: false),
      ]),
  Question(title: 'Which player is known as "El Fenómeno"?', answers: [
    Answer(title: 'Ronaldo Nazário', isCorrect: true),
    Answer(title: 'Ronaldinho', isCorrect: false),
    Answer(title: 'Romário', isCorrect: false),
    Answer(title: 'Pelé', isCorrect: false),
  ]),
  Question(title: 'Which team won the first Premier League title?', answers: [
    Answer(title: 'Manchester United', isCorrect: true),
    Answer(title: 'Blackburn Rovers', isCorrect: false),
    Answer(title: 'Arsenal', isCorrect: false),
    Answer(title: 'Chelsea', isCorrect: false),
  ]),
  Question(
      title:
          'Which player holds the record for the most goals in football history?',
      answers: [
        Answer(title: 'Cristiano Ronaldo', isCorrect: true),
        Answer(title: 'Lionel Messi', isCorrect: false),
        Answer(title: 'Pelé', isCorrect: false),
        Answer(title: 'Romário', isCorrect: false),
      ]),
  Question(title: 'Which club is nicknamed "The Blues"?', answers: [
    Answer(title: 'Chelsea', isCorrect: true),
    Answer(title: 'Manchester City', isCorrect: false),
    Answer(title: 'Everton', isCorrect: false),
    Answer(title: 'Leicester City', isCorrect: false),
  ]),
  Question(title: 'Which country won the UEFA Euro 2020?', answers: [
    Answer(title: 'Italy', isCorrect: true),
    Answer(title: 'England', isCorrect: false),
    Answer(title: 'Spain', isCorrect: false),
    Answer(title: 'France', isCorrect: false),
  ]),
];

class AnalyticsData {
  final int followers;
  final double followerGrowth;
  final int weeklyGrowth;
  final int gamesPublished;
  final int totalPlayers;
  final double retention;
  final List<DailyParticipation> peakParticipation;
  final List<DailyGamePublished> gamesPublishedData;
  final GameDistribution gameDistribution;
  final UserDemographics demographics;

  AnalyticsData({
    required this.followers,
    required this.followerGrowth,
    required this.weeklyGrowth,
    required this.gamesPublished,
    required this.totalPlayers,
    required this.retention,
    required this.peakParticipation,
    required this.gamesPublishedData,
    required this.gameDistribution,
    required this.demographics,
  });
}

class DailyParticipation {
  final DateTime date;
  final double value;

  DailyParticipation({required this.date, required this.value});
}

class DailyGamePublished {
  final DateTime date;
  final int count;

  DailyGamePublished({required this.date, required this.count});
}

class GameDistribution {
  final double ludoKingPercentage;
  final double snakeLadderPercentage;

  GameDistribution({
    required this.ludoKingPercentage,
    required this.snakeLadderPercentage,
  });
}

class UserDemographics {
  final Map<String, double> locationDistribution;
  final Map<String, double> genderDistribution;
  final Map<String, double> ageDistribution;

  UserDemographics({
    required this.locationDistribution,
    required this.genderDistribution,
    required this.ageDistribution,
  });
}

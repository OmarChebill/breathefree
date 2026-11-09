import '../models/user_profile.dart';

class Calculations {
  static double dailySavings(UserProfile p) =>
      p.cigarettesPerDay / UserProfile.cigarettesPerPack * p.packPrice;

  static int daysSmokeFree(UserProfile p, [DateTime? now]) {
    final days = (now ?? DateTime.now()).difference(p.quitDate).inDays;
    return days < 0 ? 0 : days;
  }

  static int cigarettesAvoided(UserProfile p, [DateTime? now]) =>
      daysSmokeFree(p, now) * p.cigarettesPerDay;

  static double moneySaved(UserProfile p, [DateTime? now]) =>
      daysSmokeFree(p, now) * dailySavings(p);
}
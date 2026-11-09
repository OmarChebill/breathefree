class UserProfile {
  const UserProfile({
    required this.name,
    required this.cigarettesPerDay,
    required this.packPrice,
    required this.yearsSmoking,
    required this.quitDate,
  });

  static const cigarettesPerPack = 20;

  final String name;
  final int cigarettesPerDay;
  final double packPrice;
  final int yearsSmoking;
  final DateTime quitDate;

  /// Returns a copy with some fields changed (the object itself is immutable).
  UserProfile copyWith({
    String? name,
    int? cigarettesPerDay,
    double? packPrice,
    int? yearsSmoking,
    DateTime? quitDate,
  }) =>
      UserProfile(
        name: name ?? this.name,
        cigarettesPerDay: cigarettesPerDay ?? this.cigarettesPerDay,
        packPrice: packPrice ?? this.packPrice,
        yearsSmoking: yearsSmoking ?? this.yearsSmoking,
        quitDate: quitDate ?? this.quitDate,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'cigarettesPerDay': cigarettesPerDay,
        'packPrice': packPrice,
        'yearsSmoking': yearsSmoking,
        'quitDate': quitDate.toIso8601String(),
      };

  factory UserProfile.fromJson(Map<String, dynamic> j) => UserProfile(
        name: j['name'] as String,
        cigarettesPerDay: j['cigarettesPerDay'] as int,
        packPrice: (j['packPrice'] as num).toDouble(),
        yearsSmoking: j['yearsSmoking'] as int,
        quitDate: DateTime.parse(j['quitDate'] as String),
      );
}
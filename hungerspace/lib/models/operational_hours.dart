// lib/models/operational_hours.dart - NEW FILE
class OperationalHours {
  final String till12pm;
  final String from12pmTo2am;

  OperationalHours({
    required this.till12pm,
    required this.from12pmTo2am,
  });

  factory OperationalHours.fromJson(Map<String, dynamic> json) {
    return OperationalHours(
      till12pm: json['till_12pm'] as String,
      from12pmTo2am: json['from_12pm_to_2am'] as String,
    );
  }
}
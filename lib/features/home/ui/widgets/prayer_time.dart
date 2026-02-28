

class PrayerTime {
  final String name;
  final String timeString;
  final DateTime date;

  PrayerTime(this.name, this.timeString, this.date);

  DateTime get time {
    final parts = timeString.split(':');
    return DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }
}

import 'package:fast_buddy/data/Database.dart';

class StatsHelper {
  static Future<Map<String, dynamic>> getStats() async {
    final fasts = await FastingDatabase.getFasts();
    final numFasts = fasts.length;
    final totalDuration = fasts.fold(
        Duration(),
            (previousValue, element) =>
        previousValue + (element.end!.difference(element.start)));
    final totalAutophagyDuration = fasts.fold(
        Duration(),
            (previousValue, element) => previousValue +
            (element.end!.difference(element.start) >= Duration(hours: 18)
                ? element.end!.difference(element.start) - Duration(hours: 18)
                : Duration.zero));
    final avgDuration =
    numFasts > 0 ? totalDuration ~/ numFasts : Duration();
    final maxDuration = fasts.fold(
      Duration.zero,
          (previousValue, element) {
        final duration = element.end!.difference(element.start);
        return previousValue > duration ? previousValue : duration;
      },
    );

    return {
      'numFasts': numFasts,
      'totalDuration': totalDuration,
      'totalAutophagyDuration': totalAutophagyDuration,
      'avgDuration': avgDuration,
      'maxDuration': maxDuration,
    };
  }
}

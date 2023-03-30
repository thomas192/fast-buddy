import 'package:flutter/material.dart';
import 'package:fast_buddy/stats/widgets/StatsPodium.dart';
import 'package:fast_buddy/stats/widgets/StatsList.dart';
import 'package:fast_buddy/stats/helpers/StatsHelper.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stats'),
        backgroundColor: Colors.grey[50],
        iconTheme: IconThemeData(
          color: Colors.black,
          size: contextHeight * 0.046,
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: StatsHelper.getStats(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            final numFasts = snapshot.data!['numFasts'];
            final totalDuration = snapshot.data!['totalDuration'];
            final totalAutophagyDuration = snapshot.data!['totalAutophagyDuration'];
            final avgDuration = snapshot.data!['avgDuration'];
            final maxDuration = snapshot.data!['maxDuration'];
            final List<Map<String, dynamic>> items = [
              {
                'title': 'Total',
                'duration': _formatDurationInDays(totalDuration),
                'icon': Icons.access_time,
              },
              {
                'title': 'Autophagy',
                'duration': _formatDurationInDays(totalAutophagyDuration),
                'icon': Icons.local_fire_department,
              },
            ];
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: contextHeight * 0.01,
                ),
                SizedBox(
                  height: contextHeight * 0.24,
                  child: StatsPodium(
                    numFasts: numFasts.toString(),
                    avgDuration: _formatDurationInHours(avgDuration),
                    maxDuration: _formatDurationInHours(maxDuration),
                  ),
                ),
                StatsList(items: items),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  String _formatDurationInHours(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  String _formatDurationInDays(Duration duration) {
    final days = duration.inDays;
    return days.toString();
  }

}

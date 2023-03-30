import 'package:flutter/material.dart';
import 'package:fast_buddy/themes/GreenTheme.dart';
import 'dart:async';
import 'package:fast_buddy/data/Database.dart';
import 'package:fast_buddy/history/screens/FastListScreen.dart';
import 'package:fast_buddy/stats/screens/StatsScreen.dart';
import 'package:fast_buddy/fast/widgets/Fast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FastingDatabase.initialize();

  runApp(MaterialApp(
    home: FastingApp(),
    theme: GreenTheme.greenTheme(),
  ));
}

class FastingApp extends StatefulWidget {
  @override
  _FastingAppState createState() => _FastingAppState();
}

class _FastingAppState extends State<FastingApp> {
  DateTime? _startTime;
  int? _currFastId;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    FastingDatabase.getLatestFast().then((fast) {
      if (fast != null && fast.end == null) {
        setState(() {
          _startTime = fast.start;
          _currFastId = fast.id;
        });
        startTimer();
      }
    });
  }

  String getDurationString() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }
    if (_startTime == null) { return "00:00:00"; }
    var duration = DateTime.now().difference(_startTime!);
    var seconds = duration.inSeconds % 60;
    var minutes = (duration.inSeconds ~/ 60) % 60;
    var hours = (duration.inSeconds ~/ 3600);
    return "${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}";
  }

  double getProgressValue() {
    if (_startTime == null) { return 0; }
    var totalFastingTime = 16 * 60 * 60;
    var fastingTimeElapsed = DateTime.now().difference(_startTime!).inSeconds;
    var progressValue = fastingTimeElapsed / totalFastingTime;
    return progressValue.clamp(0, 1);
  }

  void startFast() async {
    setState(() {
      _startTime = DateTime.now();
    });
    startTimer();
    _currFastId = await FastingDatabase.addStart(_startTime!);
  }

  Future<void> endFast() async {
    await FastingDatabase.addEnd(_currFastId!, DateTime.now());
    setState(() {
      _startTime = null;
      _currFastId = null;
    });
    resetTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  void resetTimer() {
    _timer?.cancel();
    _timer = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton (
          icon: Icon(Icons.bar_chart_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StatScreen()),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.playlist_add_check_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FastListScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green[400]!,
              Colors.green[800]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_startTime == null)
                Fast(
                    onPressed: startFast,
                    label: "Start Fast",
                    progress: 0),
              if (_startTime != null)
                Fast(
                    onPressed: endFast,
                    label: getDurationString(),
                    progress: getProgressValue()),
            ],
          ),
        ),
      ),
    );
  }

}
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerApp extends StatefulWidget {
  final taskName;
  final taskTimer;
  const TimerApp({
    super.key,
    this.taskName,
    this.taskTimer
  });
  @override
  State<TimerApp> createState() => _TimerState();
}

class _TimerState extends State<TimerApp> {
  late Stopwatch stopwatch;
  late Timer t;

  void handleStartStop()
  {
    print(stopwatch.elapsed.inSeconds);
    if(stopwatch.isRunning) {
      stopwatch.stop();
    }
    else {
      stopwatch.start();
    }
  }
  String returnFormattedText() {
    var sec = stopwatch.elapsed.inSeconds;

    String seconds = (sec % 60).toString().padLeft(2, "0");
    String minutes = ((sec ~/ 60) % 60).toString().padLeft(2, "0");
    String hours = ((sec ~/ 60) ~/ 60).toString().padLeft(2, "0");

    return "$hours:$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();

    t = Timer.periodic( const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.taskName}",
          style: TextStyle(
            fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () {
                    handleStartStop();
                  },
                  padding: EdgeInsets.all(0),
                  child: Container(
                    height: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue,
                          width: 4,
                        )
                    ),
                    child: Text(
                      returnFormattedText(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                CupertinoButton(
                  onPressed: () {
                    stopwatch.reset();
                  },
                  padding: EdgeInsets.all(0),
                  child: const Text(
                    "Reset",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
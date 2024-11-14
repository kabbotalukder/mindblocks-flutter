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

  var sec;

  List<int> updatedTask = [];

  void handleStartStop()
  {
    if(stopwatch.isRunning) {
      stopwatch.stop();
    }
    else {
      stopwatch.start();
    }
  }
  String returnFormattedText() {
    sec = stopwatch.elapsed.inSeconds + (widget.taskTimer);

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
          "${widget.taskName} | ${widget.taskTimer}",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: ElevatedButton(onPressed: () {
                        updatedTask.add(sec);
                        updatedTask.add(1);
                        Navigator.pop(context, updatedTask);
                      },
                          child: Icon(
                            Icons.hourglass_empty,
                            color: Colors.white,
                          ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(Colors.deepPurpleAccent),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: ElevatedButton(onPressed: () {
                        updatedTask.add(sec);
                        updatedTask.add(2);
                        Navigator.pop(context, updatedTask);
                      },
                        child: Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: ElevatedButton(onPressed: () {
                        updatedTask.add(0);
                        updatedTask.add(0);
                        Navigator.pop(context, updatedTask);
                      },
                        child: Icon(
                          Icons.restart_alt,
                          color: Colors.white,
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(Colors.grey),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: ElevatedButton(onPressed: () {
                        updatedTask.add(sec);
                        updatedTask.add(3);
                        Navigator.pop(context, updatedTask);
                      },
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(Colors.red),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: ElevatedButton(onPressed: () {
                        updatedTask.add(sec);
                        updatedTask.add(4);
                        Navigator.pop(context, updatedTask);
                      },
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
                        ),
                      ),
                    ),
                  ],
                ),
                // CupertinoButton(
                //   onPressed: () {
                //     stopwatch.reset();
                //   },
                //   padding: EdgeInsets.all(0),
                //   child: const Icon(Icons.refresh)
                // ),
              ],
            ),
          )
      ),
    );
  }
}
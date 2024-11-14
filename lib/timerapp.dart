import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum IconLabel {
  notStarted("Not Started", Icons.timer),
  inProgress("In Progress", Icons.hourglass_empty_sharp),
  delayed("Delayed", Icons.calendar_month),
  dropped("Dropped", Icons.close),
  done("Done", Icons.check_sharp);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class TimerApp extends StatefulWidget {
  final taskName;
  final taskCat;
  final estTime;
  final taskTimer;
  const TimerApp({
    super.key,
    this.taskName,
    this.taskCat,
    this.estTime,
    this.taskTimer
  });
  @override
  State<TimerApp> createState() => _TimerState();
}

class _TimerState extends State<TimerApp> {
  late Stopwatch stopwatch;
  late Timer t;
  var sec;
  List<String> statusLabel = ["Not Started", "In Progress", "Delayed", "Dropped", "Done"];
  List<IconData> statusIcon = [Icons.timer, Icons.hourglass_empty_sharp, Icons.calendar_month, Icons.close, Icons.check_sharp];

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

  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    var idx = -1;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text(
      //     "${widget.taskName}",
      //     style: TextStyle(
      //       fontWeight: FontWeight.w500
      //     ),
      //   ),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),
      body: AnimatedContainer(
          decoration: BoxDecoration(
            color:
            (stopwatch.isRunning == true)
            ? const Color(0xbb8D33FF)
            : const Color(0xfff1f1f1),
          ),
          duration: const Duration(milliseconds: 1000),
          child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 20,),
                SizedBox(height: 20,),
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
                          color: Colors.black,
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
                Container(
                    width: size.width * 0.90,
                    // height: size.width * 0.15,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              children: [
                                Text(
                                  "${widget.taskCat}",
                                  style:
                                  TextStyle(
                                    color: const Color(0xff454545),
                                    fontSize: size.width * .035,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                (int.parse(widget.estTime) != 0)
                                    ? Text(" - ${int.parse(widget.estTime) ~/ 60}h ${int.parse(widget.estTime) % 60}m",
                                  style: TextStyle(
                                      color: const Color(0xff666666),
                                      fontSize: size.width * .035,
                                      fontWeight: FontWeight.w400
                                  ),
                                )
                                    : SizedBox()
                              ]
                          ),
                          Text(
                            "${widget.taskName}",
                            style: TextStyle(
                                color: const Color(0xff000000),
                                fontSize: size.width * .045,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          (stopwatch.isRunning)
                          ? SizedBox(height: 7,)
                          : AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(2.5, 2.5, 2.5, 0),
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
                                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(2.5, 2.5, 2.5, 0),
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
                                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.orange),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(2.5, 2.5, 2.5, 0),
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
                                  padding: const EdgeInsets.fromLTRB(2.5, 2.5, 2.5, 0),
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
                          ),



                          // Center(
                          //   child: ElevatedButton(
                          //     style: ButtonStyle(
                          //       padding: WidgetStatePropertyAll(const EdgeInsets.all(17.0),),
                          //       backgroundColor: WidgetStatePropertyAll(Colors.green),
                          //     ),
                          //     onPressed: () {},
                          //     child: Icon(Icons.save,
                          //       color: Colors.white,
                          //     )
                          //   ),
                          // )
                        ],
                      ),
                    )
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

      ),
    );
  }
}
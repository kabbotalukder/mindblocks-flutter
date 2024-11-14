import 'package:flutter/material.dart';
import 'package:mindblocks/input_form.dart';
import 'package:mindblocks/timerapp.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});



  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  // int totalEstTime = 0;
  // int totalTimerTime = 0;
  // List<String> tasks = ["Demo Task"];
  // List<String> categories = ["Demo Category"];
  // List<String> estTime = ["120"];
  // List<int> timerTime = [60];
  // List<int> taskStatus = [0];

  int totalEstTime = 0;
  int totalTimerTime = 0;
  List<String> tasks = [];
  List<String> categories = [];
  List<String> estTime = [];
  List<int> timerTime = [];
  List<int> taskStatus = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(
                builder: (value) => InputForm(),
            ),
          ).then((newTask) {
            if(newTask != null){
              setState(() {
                tasks.add(newTask[0]);
                categories.add(newTask[1]);
                estTime.add(newTask[2]);
                timerTime.add(0);
                taskStatus.add(0);
                totalEstTime = 0;
                totalTimerTime = 0;
                for(int i = 0; i < estTime.length; i++){
                  totalEstTime += int.parse(estTime[i]);
                  totalTimerTime += timerTime[i];
                }
              });
            }
            });
        },
        backgroundColor: const Color(0xff8D33FF),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        // width: double.infinity,
        // height: double.infinity,
        child: Column(
          children: [
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  const Text(
                    "Total Time Blocks",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.3),
                      //     spreadRadius: 2,
                      //     blurRadius: 10,
                      //     offset: const Offset(0, 3), // changes position of shadow
                      //   ),
                      // ],
                    ),
                    width: size.width * 0.7,
                    height: size.width * .15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${totalTimerTime ~/ 3600}h ${totalTimerTime ~/60 % 60}m / ${totalEstTime ~/ 60}h ${totalEstTime % 60}m",
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff2D0C57)
                          ),
                        ),
                        // ElevatedButton(
                        //     onPressed: (){
                        //       for(int i = 0; i < tasks.length;i++){
                        //         print(tasks[i]);
                        //         print(categories[i]);
                        //         print(estTime[i]);
                        //         print(timerTime[i]);
                        //       }
                        //     },
                        //     child: Icon(Icons.refresh)
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            tasks.isEmpty
            ? Expanded(
                child: Center(child: const Text("there are no tasks!",
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color(0xaa000000)
                  ),
                )))
            : Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index){
                  // print("Building item at index: $index, tasks length: ${tasks.length}");
                  return AnimatedContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color:
                          taskStatus[index] == 0
                          ? Colors.white
                          : taskStatus[index] == 1
                          ? Colors.deepPurpleAccent.withAlpha(100)
                          : taskStatus[index] == 2
                          ? Colors.blue.withAlpha(100)
                          : taskStatus[index] == 3
                          ? Colors.red.withAlpha(100)
                          : Colors.green.withAlpha(100),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    duration: const Duration(milliseconds: 600),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                                builder: (value) => TimerApp(
                                  taskName: tasks[index],
                                  taskTimer: timerTime[index],
                                ))).then((updatedTask) {
                                  if(updatedTask != null){
                                    setState(() {
                                      timerTime[index] = updatedTask[0];
                                      taskStatus[index] = updatedTask[1];
                                      totalEstTime = 0;
                                      totalTimerTime = 0;
                                      for(int i = 0; i < estTime.length; i++){
                                        totalEstTime += int.parse(estTime[i]);
                                        totalTimerTime += timerTime[i];
                                      }
                                    });
                                  }
                        });
                        },
                      child: ListTile(
                        trailing:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              decoration: BoxDecoration(
                                color:
                                taskStatus[index] == 0
                                ? Colors.grey
                                : taskStatus[index] == 1
                                ? Colors.deepPurpleAccent
                                : taskStatus[index] == 2
                                ? Colors.blue
                                : taskStatus[index] == 3
                                ? Colors.red
                                : Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Icon(
                                  taskStatus[index] == 0
                                  ? Icons.timer
                                  : taskStatus[index] == 1
                                  ? Icons.hourglass_empty
                                  : taskStatus[index] == 2
                                  ? Icons.calendar_month
                                  : taskStatus[index] == 3
                                  ? Icons.close
                                  : Icons.check_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            (timerTime[index] != 0)
                            ? Text("${timerTime[index] ~/ 3600}h ${timerTime[index] ~/ 60 % 60}m")
                            : Text("N/A"),
                          ],
                        ),
                        title: Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(categories[index]),
                                  SizedBox(width: 10,),
                                  (int.parse(estTime[index]) != 0)
                                  ? Text("${int.parse(estTime[index]) ~/ 60}h ${int.parse(estTime[index]) % 60}m")
                                  : SizedBox(),
                                ],
                              ),
                              Text(tasks[index])
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
              }),
            ),
          ],
        ),
      )
    );
  }
}

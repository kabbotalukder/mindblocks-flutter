import 'package:flutter/material.dart';
import 'package:mindblocks/timerapp.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  String? newTaskTitle;
  String? newTaskCategory;
  String? newTaskEst;

  // var taskList = [
  //   {
  //     "taskName": "task 1",
  //     "taskCategory": "coding",
  //     "taskEstTime": 1800,
  //     "taskTimer": 0
  //   }
  // ];

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // floatingActionButton: GestureDetector(
      //   onTap: (){
      //     print("elevated button");
      //   },
      //   child: Material(
      //     borderRadius: BorderRadius.circular(15),
      //     elevation: 10,
      //     child: Container(
      //       width: 70,
      //       height: 70,
      //       decoration: BoxDecoration(
      //         color: Colors.purple,
      //         borderRadius: BorderRadius.circular(15)
      //       ),
      //       child: Center(
      //         child: Icon(
      //           Icons.add,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  height: 600,
                  width: 400,
                  child: Column(
                    children: [
                      const Text("task"),
                      TextField(
                        autofocus: true,
                        onChanged: (
                            (value) {
                              widget.newTaskTitle = value;
                            }
                        ),
                      ),
                      const Text("category"),
                      TextField(
                        autofocus: true,
                        onChanged: (
                            (value) {
                              widget.newTaskCategory = value;
                            }
                        ),
                      ),
                      const Text("estimated time"),
                      TextField(
                        autofocus: true,
                        onChanged: (
                            (value) {
                              widget.newTaskEst = value;
                            }
                        ),
                      ),
                      TextButton(
                          onPressed: (){

                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.save
                          )
                      )
                    ],
                  ),
                ),
              )
          );
        },
        backgroundColor: Colors.purple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: double.infinity,
                height: 130,
                child: const Column(
                  children: [
                    SizedBox(height: 20,),
                    Text(
                      "Total Time Blocks",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      "2h 30m / 3h 30m",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400
                      ),
                    )
                  ],
                ),
              ),
            ),
            //const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              height: 645,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index){
                  return AnimatedContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    duration: const Duration(milliseconds: 600),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                                builder: (value) => const TimerApp(
                                  taskName: "Task Prop",
                                  taskTimer: 20,
                                )));
                        },
                      child: ListTile(
                        trailing: GestureDetector(
                          onTap: (){},
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 600),
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                              Text("2h 30m")
                            ],
                          ),
                        ),
                        title: const Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Category"),
                                  SizedBox(width: 10,),
                                  Text("3h 30m"),
                                ],
                              ),
                              Text("Task")
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

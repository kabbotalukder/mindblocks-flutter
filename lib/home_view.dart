import 'package:flutter/material.dart';
import 'package:mindblocks/input_form.dart';
import 'package:mindblocks/timerapp.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});



  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<String> tasks = [];
  List<String> categories = [];
  List<String> estTime = [];
  List<String> timerTime = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                timerTime.add("00h 00m");
              });
            }
            });
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
                height: 170,
                child: Column(
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
                      "00h 00m / 00h 00m",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    ElevatedButton(
                        onPressed: (){
                          for(int i = 0; i < tasks.length;i++){
                            print(tasks[i]);
                          }
                        },
                        child: Icon(Icons.refresh)
                    ),
                  ],
                ),
              ),
            ),
            tasks.isEmpty
            ? const Text("there are no tasks!")
            : Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index){
                  print("Building item at index: $index, tasks length: ${tasks.length}");
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
                                builder: (value) => TimerApp(
                                  taskName: tasks[index],
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
                              Text(timerTime[index])
                            ],
                          ),
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
                                  Text(estTime[index]),
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

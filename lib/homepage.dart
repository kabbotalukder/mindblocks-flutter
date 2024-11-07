import 'package:flutter/material.dart';
import 'package:mindblocks/timerapp.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Task Name",
      //     style: TextStyle(
      //         fontWeight: FontWeight.w500
      //     ),
      //   ),
      //   centerTitle: true,
      //   automaticallyImplyLeading: true,
      // ),
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (value) => const TimerApp()));
                    },
                    child: Text("Task 1"),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (value) => const TimerApp()));
                    },
                    child: Text("Task 2"),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (value) => const TimerApp()));
                    },
                    child: Text("Task 3"),
                ),
              ],
            ),
          )
      ),
    );;
  }
}
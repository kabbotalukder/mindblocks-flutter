import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mindblocks/home_view.dart';

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController taskTextEditingController = TextEditingController();


  List<String> availCategories = ["Work", "Study", "Programming"];
  List<String> estHours = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
  List<String> estMinutes = ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"];
  List<String> newTask = [];
  String selectedCategory = "";
  var selectedEstTime = 0;
  var selectedHour = 0;
  var selectedMinutes = 0;


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        title: Text("Add Task",
          style: TextStyle(
            fontSize: size.width * .055
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(21.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: taskTextEditingController,
                    decoration: const InputDecoration(
                      labelText: "Task"
                    ),
                    validator: (value) {
                      if(value != null && value.isNotEmpty){
                        return null;
                      }
                      return "Invalid Task!";
                    },
                  ),
                  SizedBox(height: 17,),
                  DropdownMenu(
                    width: 380,
                    label: const Text('Category'),
                    hintText: "Category",
                    // initialSelection: availCategories.first,
                    dropdownMenuEntries: availCategories.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(value: value, label: value);
                    }).toList(),
                    onSelected: (String? value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
                        child: DropdownMenu(
                          width: 175,
                          label: const Text('Estimated Hours'),
                          initialSelection: estHours.first,
                          dropdownMenuEntries: estHours.map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(value: value, label: value);
                          }).toList(),
                          onSelected: (String? value) {
                            setState(() {
                              selectedHour = int.parse(value!) * 60;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(17, 17, 0, 0),
                        child: DropdownMenu(
                          width: 175,
                          label: const Text('Estimated Minutes'),
                          initialSelection: estMinutes.first,
                          dropdownMenuEntries: estMinutes.map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(value: value, label: value);
                          }).toList(),
                          onSelected: (String? value) {
                            setState(() {
                              selectedMinutes = int.parse(value!);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: size.width * .90,
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Color(0xff8D33FF))
              ),
              onPressed: (){
                selectedEstTime = selectedHour + selectedMinutes;
                if(_formKey.currentState!.validate()){
                  setState(() {
                    newTask.add(taskTextEditingController.text);
                    newTask.add(selectedCategory);
                    newTask.add(selectedEstTime.toString());
                  });
                  taskTextEditingController.clear();
                  Navigator.pop(context, newTask);
                }
              },
              child: const Icon(Icons.done,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 0,
              itemBuilder: (context, index){
                return ListTile(
                );
              }
            ),
          )
        ],
      ),
    );
  }
}

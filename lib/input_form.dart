import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mindblocks/home_view.dart';

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController taskTextEditingController = TextEditingController();
  final TextEditingController estTimeTextEditingController = TextEditingController();


  List<String> availCategories = ["Work", "Study", "Programming"];
  List<String> newTask = [];


  @override
  Widget build(BuildContext context) {
    String selectedCategory = availCategories.first;
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
                  TextFormField(
                    controller: estTimeTextEditingController,
                    decoration: const InputDecoration(
                        labelText: "Estimated Time"
                    ),
                    validator: (value) {
                      if(value != null && value.isNotEmpty){
                        return null;
                      }
                      return "Invalid Estimated Time!";
                    },
                  ),
                  SizedBox(height: 17,),
                  DropdownMenu(
                    width: 380,
                    label: const Text('Category'),
                    initialSelection: availCategories.first,
                    dropdownMenuEntries: availCategories.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(value: value, label: value);
                    }).toList(),
                    onSelected: (String? value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(Colors.green)
            ),
            onPressed: (){
              if(_formKey.currentState!.validate()){
                setState(() {
                  newTask.add(taskTextEditingController.text);
                  newTask.add(estTimeTextEditingController.text);
                  newTask.add(selectedCategory);
                });
                taskTextEditingController.clear();
                estTimeTextEditingController.clear();
                Navigator.pop(context, newTask);
              }
            },
            child: const Icon(Icons.done,
              color: Colors.white,
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

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ran_app/schedule/schedulepage.dart';
import 'package:ran_app/schedule/task.dart';
import 'package:ran_app/schedule/todoinformationpopup.dart';

class TaskPage extends StatefulWidget {
  @override
  TaskPageState createState() => TaskPageState();
}// A State created by StatefulWidget to be displayed on screen.

class TaskPageState extends State<TaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<Task> taskList = [];
  Task currentTask = Task();

  String? _selectedOption;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Tasks'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text("These are the tasks we have so far: "),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(

              padding: EdgeInsets.all(10.0),
              child: Table(
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        border: Border.all(
                          width: 1,
                        ),
                      ),
                      children: [
                    Text("Label"),
                    Text('Area'),
                    Text('Duration'),
                    Text('Pref. Time'),
                    Text('Difficulty'),

                  ]),
                  TableRow(children: [
                    Text('Task 4'),
                    Text('Cell 5'),
                    Text('Cell 6'),
                    Text('Cell 6'),
                    Text('Hi')
                  ])
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Add Task'),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return TodoInformationPopup(titleController: titleController);
                      }
                  ).then((value) {
                    currentTask.setArea(areaDropdownValue);
                    currentTask.setLabel(titleController.text);
                    setState(() {
                      taskList.add(currentTask);

                    });

                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Done with my tasks'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }





}

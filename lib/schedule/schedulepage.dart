  import 'package:flutter/material.dart';
  import 'package:ran_app/homepage/name_input.dart';
  import 'package:ran_app/schedule/taskpage.dart';
  import 'package:time_planner/time_planner.dart';
  import 'package:intl/intl.dart';
  import 'package:ran_app/schedule/schedule.dart';
  import 'package:ran_app/schedule/task.dart';

  late Schedule schedule;
  DateTime lastScheduleDate = DateTime.now();


  class ScheduleHomePageState extends StatefulWidget {
    final List<Task> tasks; // Receive the list of tasks from previous page

    ScheduleHomePageState({required this.tasks});
    @override
    SchedulePage createState() => SchedulePage();
  }// A State created by StatefulWidget to be displayed on screen.


  class SchedulePage extends  State<ScheduleHomePageState>{
    List<TimePlannerTask> finaltasks = [];



    @override
    void initState() {
      super.initState();
      schedule = Schedule(
        scheduleDate: DateTime.now(),
        studyMethod: 'Interleaved Practice',
        workingMethod: '60',
      );
      _checkAndResetSchedule();
      _initializeSchedule();
      _populateTimePlannerTasks();

    }
    String printInfo(Task task){
      DateTime? start = schedule.taskTimeMap[task]?.start;
      DateTime? end = schedule.taskTimeMap[task]?.end;
      if(task.getLabel() != "Break") {
        return "Task " + task.getLabel() + ": " +
            DateFormat('HH:mm').format(start!) + "-" +
            DateFormat('HH:mm').format(end!);
      }else{
        return  "Break from" + ": " +
            DateFormat('HH:mm').format(start!) + "-" +
            DateFormat('HH:mm').format(end!);
      }
    }
    void _addTaskTimeObject(BuildContext context, Task currTask) {
      Color color;
      if(currTask.getLabel() == "Break"){
          color = Colors.blue;
      }else{
        color = Colors.red;
      }
      setState(() {
        int? hour = schedule.taskTimeMap[currTask]?.start.hour;
        int? minutes = schedule.taskTimeMap[currTask]?.start.minute;
        finaltasks.add(
          TimePlannerTask(
            color: color,
            dateTime: TimePlannerDateTime(
              day: 0,
              hour: hour!,
              minutes: minutes!,),
            minutesDuration:  currTask.duration,
            daysDuration: 1,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(printInfo(currTask))));
            },
            child: Text(
              '${currTask.getLabel()}',
              style: TextStyle(color: Colors.grey[350], fontSize: 12),
            ),
          ),
        );
      });
    }

    void _populateTimePlannerTasks() {
      schedule.scheduleTime();
      schedule.taskTimeMap.forEach((task, timeSlot) {
        print("Adding ${task.getLabel()} to the final tasks.");
        _addTaskTimeObject(context, task);
      });
    }



    void _initializeSchedule() {
      schedule.setTasks(taskList);
      schedule.initializeTasks();
    }

    void _checkAndResetSchedule() {
      DateTime now = DateTime.now();
      if (now.day != lastScheduleDate.day || now.month != lastScheduleDate.month || now.year != lastScheduleDate.year) {
        // Reset the schedule
        _resetSchedule();
      }
      lastScheduleDate = now;
    }

    // Method to reset the schedule
    void _resetSchedule() {
      setState(() {
        finaltasks.clear();
        taskList.clear();// Clear the current tasks
        schedule = Schedule(
          scheduleDate: DateTime.now(),
          studyMethod: 'Interleaved Practice',
          workingMethod: '60',
        );

      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [

            Expanded(
              flex: 8,
              child:TimePlanner(
                // time will be start at this hour on table
                startHour: 0,
                // time will be end at this hour on table
                endHour: 23,
                // each header is a column and a day
                headers: [
                  TimePlannerTitle(
                    date: DateFormat('MM-dd-yyyy').format(DateTime.now()),
                    title: DateFormat('EEEE').format(DateTime.now()), /// e.g Thursday,
                  ),
                ],
                style: TimePlannerStyle(
                  backgroundColor: Colors.white,
                  // default value for height is 80
                  cellHeight: 100,
                  // default value for width is 90
                  cellWidth: 200,

                  dividerColor: Colors.black,
                  showScrollBar: true,
                  horizontalTaskPadding: 5,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                // List of task will be show on the time planner
                tasks: finaltasks,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                  child: Text('Enter Tasks'),
                  onPressed: () {
                      setState(() {
                        _navigateToTaskPage(context);
                      });
                  },
                ),
              ),
            ),
          ]
        )
      );
    }
    void _navigateToTaskPage(BuildContext context) {
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => TaskPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      });
    }
  }
import 'package:flutter/material.dart';
import 'package:ran_app/homepage/homepage.dart';

class TwelfthQuestion extends StatefulWidget {
  @override
  TwelfthQuestionState createState() => TwelfthQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class TwelfthQuestionState extends State<TwelfthQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 12'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text("Are you easily distracted by external stimuli, such as noise or movement?"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Yes'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToHomePage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('No'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToHomePage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToHomePage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => MyHomePage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}

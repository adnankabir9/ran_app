import 'package:flutter/material.dart';
import 'package:ran_app/questions/question3.dart';

var answer2 = '';

class SecondQuestion extends StatefulWidget {
  @override
  SecondQuestionState createState() => SecondQuestionState();
}

class SecondQuestionState extends State<SecondQuestion> {
  double _currentSliderValue = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 2'),
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
                child: Text(
                  "On a scale of 1 to 10, how motivated do you feel to accomplish tasks and challenges",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Slider(
            value: _currentSliderValue,
            min: 1,
            max: 10,
            divisions: 9,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Done'),
                onPressed: () {
                  setState(() {
                    answer2 = _currentSliderValue.toString();
                  });
                  _navigateToThirdPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToThirdPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => ThirdQuestion(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}

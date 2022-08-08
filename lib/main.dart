import 'package:flutter/material.dart';
import 'brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
Brain brain=Brain();
void main() {
  runApp(quizzex());
}
class quizzex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Quizzex'),
      ),
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Quizpage(),
          ),
        ),
      ),
    );
  }
}
class Quizpage extends StatefulWidget {
  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  List<Icon> score=[];
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = brain.getAnswer();

    setState(() {
      if (brain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        brain.reset();

        score = [];
      }

      else {
        if (userPickedAnswer == correctAnswer) {
          score.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          score.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        brain.nextQuestion();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 5,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(brain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),

            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(textColor: Colors.white,color: Colors.green,
              child: Text('TRUE',style: TextStyle(fontSize: 20.0),),onPressed: (){
                checkAnswer(true);
                },
                )
              ),
              ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                color: Colors.red,
                child: Text(
                  'FALSE',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                 checkAnswer(false);
                  }
                ),//The user picked false.
              ),
            ),
          Row(
            children:score,
          )
        ]
    );
  }
}

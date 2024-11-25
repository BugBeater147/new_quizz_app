import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final List<dynamic> questions;

  QuizScreen({required this.questions});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;

  void _answerQuestion(String userAnswer) {
    final correctAnswer = widget.questions[currentIndex]['correct_answer'];
    setState(() {
      if (userAnswer == correctAnswer) {
        score++;
      }
      if (currentIndex < widget.questions.length - 1) {
        currentIndex++;
      } else {
        _showSummary();
      }
    });
  }

  void _showSummary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Center(
          child: Text("Quiz Complete! Your Score: $score"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Quiz")),
        body: Center(
          child: Text("No Questions Available!"),
        ),
      );
    }

    final question = widget.questions[currentIndex];
    final answers = [
      ...question['incorrect_answers'],
      question['correct_answer']
    ];
    answers.shuffle(); // Randomize options

    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${currentIndex + 1}/${widget.questions.length}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              question['question'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ...answers.map((answer) {
              return ElevatedButton(
                onPressed: () => _answerQuestion(answer),
                child: Text(answer),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

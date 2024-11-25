import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final List<Map<String, dynamic>> questionSummary;

  SummaryScreen({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.questionSummary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Summary"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quiz Complete!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Total Questions: $totalQuestions",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Correct Answers: $correctAnswers",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              "Questions Breakdown:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: questionSummary.length,
                itemBuilder: (context, index) {
                  final question = questionSummary[index];
                  return ListTile(
                    title: Text(question['question']),
                    subtitle: Text("Your Answer: ${question['userAnswer']}"),
                    trailing: question['isCorrect']
                        ? Icon(Icons.check, color: Colors.green)
                        : Icon(Icons.close, color: Colors.red),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the setup screen
                  },
                  child: Text("Retake Quiz"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Text("Exit"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

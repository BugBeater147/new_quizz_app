import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'quiz_screen.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int _numQuestions = 5;
  String? _selectedCategory;
  String? _selectedDifficulty;
  String? _selectedType;
  List<dynamic> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() async {
    try {
      final categories = await ApiService.fetchCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  void _startQuiz() async {
    final queryParams = {
      'amount': _numQuestions.toString(),
      'category': _selectedCategory ?? '',
      'difficulty': _selectedDifficulty ?? '',
      'type': _selectedType ?? '',
    };

    try {
      final questions = await ApiService.fetchQuestions(queryParams);
      if (questions.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizScreen(questions: questions),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("No questions available for the selected options.")),
        );
      }
    } catch (e) {
      print("Error fetching questions: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz Setup")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Number of Questions"),
            DropdownButton<int>(
              value: _numQuestions,
              items: [5, 10, 15].map((value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (newValue) =>
                  setState(() => _numQuestions = newValue!),
            ),
            SizedBox(height: 16),
            Text("Category"),
            DropdownButton<String>(
              value: _selectedCategory,
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category['id'].toString(),
                  child: Text(category['name']),
                );
              }).toList(),
              onChanged: (newValue) =>
                  setState(() => _selectedCategory = newValue),
            ),
            SizedBox(height: 16),
            Text("Difficulty"),
            DropdownButton<String>(
              value: _selectedDifficulty,
              items: ["easy", "medium", "hard"].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) =>
                  setState(() => _selectedDifficulty = newValue),
            ),
            SizedBox(height: 16),
            Text("Type"),
            DropdownButton<String>(
              value: _selectedType,
              items: ["multiple", "boolean"].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                      value == "multiple" ? "Multiple Choice" : "True/False"),
                );
              }).toList(),
              onChanged: (newValue) => setState(() => _selectedType = newValue),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _startQuiz,
              child: Text("Start Quiz"),
            ),
          ],
        ),
      ),
    );
  }
}

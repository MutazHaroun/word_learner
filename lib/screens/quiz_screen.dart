
import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/word.dart';
import 'dart:math';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final DBHelper dbHelper = DBHelper();
  List<Word> words = [];
  int currentIndex = 0;
  int score = 0;
  bool isLoading = true;
  List<String> options = [];
  String question = '';

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  Future _loadWords() async {
    setState(() => isLoading = true);
    words = await dbHelper.getWords();
    words.shuffle();
    setState(() {
      isLoading = false;
    });
    _setupQuestion();
  }

  void _setupQuestion() {
    if (currentIndex >= words.length) return;
    final correct = words[currentIndex];
    // build options: correct + 3 random others (if available)
    final otherWords = List<Word>.from(words)..removeAt(currentIndex);
    otherWords.shuffle();
    final opts = <String>[correct.translation];
    for (int i = 0; i < min(3, otherWords.length); i++) {
      opts.add(otherWords[i].translation);
    }
    opts.shuffle();
    setState(() {
      question = correct.term;
      options = opts;
    });
  }

  void _answer(String chosen) {
    final correct = words[currentIndex].translation;
    final isCorrect = chosen == correct;
    if (isCorrect) score++;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? 'Correct!' : 'Wrong'),
        content: Text(isCorrect ? 'Good job.' : 'Correct answer: $correct'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _nextQuestion();
            },
            child: const Text('Next'),
          )
        ],
      ),
    );
  }

  void _nextQuestion() {
    if (currentIndex < words.length - 1) {
      setState(() {
        currentIndex++;
      });
      _setupQuestion();
    } else {
      // finished
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Quiz finished'),
          content: Text('Your score: $score / ${words.length}'),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            }, child: const Text('Done')),
            TextButton(onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentIndex = 0;
                score = 0;
                words.shuffle();
              });
              _setupQuestion();
            }, child: const Text('Retry')),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Question ${currentIndex + 1} of ${words.length}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 12),
                  Text(question, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  ...options.map((opt) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ElevatedButton(
                          onPressed: () => _answer(opt),
                          child: Text(opt),
                        ),
                      )),
                ],
              ),
            ),
    );
  }
}

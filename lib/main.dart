
import 'package:flutter/material.dart';
import 'screens/word_list_screen.dart';

void main() {
  runApp(const WordLearnerApp());
}

class WordLearnerApp extends StatelessWidget {
  const WordLearnerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Learner',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const WordListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

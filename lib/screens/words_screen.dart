import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/word.dart';
import 'add_edit_word_screen.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({Key? key}) : super(key: key);

  @override
  _WordsScreenState createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  final DBHelper dbHelper = DBHelper();
  List<Word> _words = [];

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  // تحميل الكلمات من قاعدة البيانات
  Future<void> _loadWords() async {
    final words = await dbHelper.getWords();
    setState(() {
      _words = words;
    });
  }

  // حذف كلمة
  Future<void> _deleteWord(int id) async {
    await dbHelper.deleteWord(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Word deleted')),
    );
    _loadWords();
  }

  // فتح شاشة الإضافة أو التعديل
  Future<void> _openAddEditScreen({Word? word}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditWordScreen(word: word)),
    );

    // إذا رجعنا بنتيجة true نعيد تحميل القائمة
    if (result == true) {
      _loadWords();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Words'),
      ),
      body: _words.isEmpty
          ? const Center(child: Text('No words added yet'))
          : ListView.builder(
        itemCount: _words.length,
        itemBuilder: (context, index) {
          final word = _words[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(word.term, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(word.translation),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: () => _openAddEditScreen(word: word),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _deleteWord(word.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddEditScreen(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

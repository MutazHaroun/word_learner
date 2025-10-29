
import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/word.dart';
import 'add_edit_word_screen.dart';
import 'quiz_screen.dart';

class WordListScreen extends StatefulWidget {
  const WordListScreen({Key? key}) : super(key: key);

  @override
  _WordListScreenState createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  final DBHelper dbHelper = DBHelper();
  List<Word> words = [];
  List<Word> filtered = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshWords();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final q = _searchController.text.toLowerCase();
    setState(() {
      filtered = words.where((w) => w.term.toLowerCase().contains(q) || w.translation.toLowerCase().contains(q)).toList();
    });
  }

  Future refreshWords() async {
    setState(() => isLoading = true);
    words = await dbHelper.getWords();
    filtered = List.from(words);
    setState(() => isLoading = false);
  }

  void _deleteWord(int id) async {
    await dbHelper.deleteWord(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Word deleted')));
    refreshWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Learner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.quiz),
            tooltip: 'Start Quiz',
            onPressed: () async {
              // Navigate to quiz only if there are at least 4 words
              final currentWords = await dbHelper.getWords();
              if (currentWords.length < 4) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add at least 4 words to start the quiz')));
                return;
              }
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuizScreen()));
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search words or translations',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: filtered.isEmpty
                      ? const Center(child: Text('No words found.'))
                      : ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final w = filtered[index];
                            return ListTile(
                              title: Text(w.term),
                              subtitle: Text(w.translation),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () async {
                                      final shouldRefresh = await Navigator.of(context).push<bool>(
                                        MaterialPageRoute(
                                          builder: (_) => AddEditWordScreen(word: w),
                                        ),
                                      );
                                      if (shouldRefresh == true) refreshWords();
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text('Delete?'),
                                        content: Text('Delete "${w.term}"?'),
                                        actions: [
                                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                                          TextButton(onPressed: () {
                                            Navigator.pop(context);
                                            _deleteWord(w.id!);
                                          }, child: const Text('Delete')),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final shouldRefresh = await Navigator.of(context).push<bool>(
            MaterialPageRoute(builder: (_) => const AddEditWordScreen()),
          );
          if (shouldRefresh == true) refreshWords();
        },
      ),
    );
  }
}

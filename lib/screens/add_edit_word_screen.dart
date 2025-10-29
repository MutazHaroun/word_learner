import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/word.dart';

class AddEditWordScreen extends StatefulWidget {
  final Word? word;
  const AddEditWordScreen({Key? key, this.word}) : super(key: key);

  @override
  _AddEditWordScreenState createState() => _AddEditWordScreenState();
}

class _AddEditWordScreenState extends State<AddEditWordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _termController = TextEditingController();
  final TextEditingController _translationController = TextEditingController();
  final DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    if (widget.word != null) {
      _termController.text = widget.word!.term;
      _translationController.text = widget.word!.translation;
    }
  }

  @override
  void dispose() {
    _termController.dispose();
    _translationController.dispose();
    super.dispose();
  }

  Future _save() async {
    if (!_formKey.currentState!.validate()) return;
    final term = _termController.text.trim();
    final translation = _translationController.text.trim();

    if (widget.word == null) {
      await dbHelper.insertWord(Word(term: term, translation: translation));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Word added')));
    } else {
      final updated = Word(id: widget.word!.id, term: term, translation: translation);
      await dbHelper.updateWord(updated);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Word updated')));
    }
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.word != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Word' : 'Add Word')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _termController,
                decoration: const InputDecoration(labelText: 'Word'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter the word' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _translationController,
                decoration: const InputDecoration(labelText: 'Translation'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter translation' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                child: Text(isEditing ? 'Save changes' : 'Add word'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

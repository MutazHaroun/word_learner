class Word {
  int? id;
  String term;
  String translation;

  Word({this.id, required this.term, required this.translation});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'term': term,
      'translation': translation,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'] as int?,
      term: map['term'] as String,
      translation: map['translation'] as String,
    );
  }
}

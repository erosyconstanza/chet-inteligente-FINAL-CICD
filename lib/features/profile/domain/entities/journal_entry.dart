class JournalEntry {
  final String id;
  final String recipeName;
  final String? recipeId;
  final String imageUrl;
  final String note;
  final DateTime date;

  JournalEntry({
    required this.id,
    required this.recipeName,
    this.recipeId,
    required this.imageUrl,
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recipeName': recipeName,
      'recipeId': recipeId,
      'imageUrl': imageUrl,
      'note': note,
      'date': date.toIso8601String(),
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      id: map['id'],
      recipeName: map['recipeName'],
      recipeId: map['recipeId'],
      imageUrl: map['imageUrl'],
      note: map['note'],
      date: DateTime.parse(map['date']),
    );
  }
}

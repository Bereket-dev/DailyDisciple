class JournalEntry {
  final int id;
  final String title;
  final String content;
  final String type; // reflection, gratitude, prayer
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? mood;

  JournalEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    this.mood,
  });

  JournalEntry copyWith({
    int? id,
    String? title,
    String? content,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? mood,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      mood: mood ?? this.mood,
    );
  }

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      type: json['type'] ?? 'reflection',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      mood: json['mood'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'mood': mood,
    };
  }
}

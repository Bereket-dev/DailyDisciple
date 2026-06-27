class SermonNote {
  final int id;
  final String title;
  final String date;
  final String sermonTopic;
  final String preacher;
  final String notes;
  final String scripture;
  final String keyPoints;
  final String quotes;
  final String? reflectionSummary;
  final String? lessonsLearned;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;

  SermonNote({
    required this.id,
    required this.title,
    required this.date,
    required this.sermonTopic,
    required this.preacher,
    required this.notes,
    required this.scripture,
    required this.keyPoints,
    required this.quotes,
    this.reflectionSummary,
    this.lessonsLearned,
    required this.createdAt,
    required this.updatedAt,
    this.isArchived = false,
  });

  SermonNote copyWith({
    int? id,
    String? title,
    String? date,
    String? sermonTopic,
    String? preacher,
    String? notes,
    String? scripture,
    String? keyPoints,
    String? quotes,
    String? reflectionSummary,
    String? lessonsLearned,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isArchived,
  }) {
    return SermonNote(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      sermonTopic: sermonTopic ?? this.sermonTopic,
      preacher: preacher ?? this.preacher,
      notes: notes ?? this.notes,
      scripture: scripture ?? this.scripture,
      keyPoints: keyPoints ?? this.keyPoints,
      quotes: quotes ?? this.quotes,
      reflectionSummary: reflectionSummary ?? this.reflectionSummary,
      lessonsLearned: lessonsLearned ?? this.lessonsLearned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  factory SermonNote.fromJson(Map<String, dynamic> json) {
    return SermonNote(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      sermonTopic: json['sermonTopic'] ?? '',
      preacher: json['preacher'] ?? '',
      notes: json['notes'] ?? '',
      scripture: json['scripture'] ?? '',
      keyPoints: json['keyPoints'] ?? '',
      quotes: json['quotes'] ?? '',
      reflectionSummary: json['reflectionSummary'],
      lessonsLearned: json['lessonsLearned'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      isArchived: json['isArchived'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'sermonTopic': sermonTopic,
      'preacher': preacher,
      'notes': notes,
      'scripture': scripture,
      'keyPoints': keyPoints,
      'quotes': quotes,
      'reflectionSummary': reflectionSummary,
      'lessonsLearned': lessonsLearned,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isArchived': isArchived,
    };
  }
}

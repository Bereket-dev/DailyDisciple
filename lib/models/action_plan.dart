class ActionPlan {
  final int id;
  final String title;
  final String description;
  final int sermonNoteId;
  final String category;
  final bool isCompleted;
  final int? completedDate;
  final int? dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  ActionPlan({
    required this.id,
    required this.title,
    required this.description,
    required this.sermonNoteId,
    required this.category,
    this.isCompleted = false,
    this.completedDate,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  ActionPlan copyWith({
    int? id,
    String? title,
    String? description,
    int? sermonNoteId,
    String? category,
    bool? isCompleted,
    int? completedDate,
    int? dueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ActionPlan(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      sermonNoteId: sermonNoteId ?? this.sermonNoteId,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      completedDate: completedDate ?? this.completedDate,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ActionPlan.fromJson(Map<String, dynamic> json) {
    return ActionPlan(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      sermonNoteId: json['sermonNoteId'] ?? 0,
      category: json['category'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      completedDate: json['completedDate'],
      dueDate: json['dueDate'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'sermonNoteId': sermonNoteId,
      'category': category,
      'isCompleted': isCompleted,
      'completedDate': completedDate,
      'dueDate': dueDate,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

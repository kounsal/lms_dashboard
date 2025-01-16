class Lesson {
  final String id;
  final String title;
  final String type;
  final String content;
  final List<dynamic> questions;
  final int duration;
  final String courseId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Lesson({
    required this.id,
    required this.title,
    required this.type,
    required this.content,
    required this.questions,
    required this.duration,
    required this.courseId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['_id'],
      title: json['title'],
      type: json['type'],
      content: json['content'],
      questions: json['questions'] ?? [],
      duration: json['duration'],
      courseId: json['courseId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

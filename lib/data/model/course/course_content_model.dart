class CourseContentModel {
  final String id;
  final String? title;
  final String? description;
  final double? price;
  final String? teacher;
  final bool? isPurchased;
  final String? preview;
  final String? thumbnail;
  final String? type;
  final int? duration;
  final String? category;
  final String? status;
  final double? rating;
  final int? studentsCount;
  final int? lessonsCount;
  final DateTime? createdAt;
  final List<Lesson>? lessons;

  CourseContentModel({
    required this.id,
    this.title,
    this.description,
    this.price,
    this.teacher,
    this.isPurchased,
    this.preview,
    this.thumbnail,
    this.type,
    this.duration,
    this.category,
    this.status,
    this.rating,
    this.studentsCount,
    this.lessonsCount,
    this.createdAt,
    this.lessons,
  });

  factory CourseContentModel.fromJson(Map<String, dynamic> json) {
    return CourseContentModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num?)?.toDouble(),
      teacher: json['teacher'],
      isPurchased: json['isPurchased'],
      preview: json['preview'],
      thumbnail: json['thumbnail'],
      type: json['type'],
      duration: json['duration'],
      category: json['category'],
      status: json['status'],
      rating: (json['rating'] as num?)?.toDouble(),
      studentsCount: json['studentsCount'],
      lessonsCount: json['lessonsCount'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      lessons: json['lessons'] != null
          ? (json['lessons'] as List)
          .map((lesson) => Lesson.fromJson(lesson))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'teacher': teacher,
      'isPurchased': isPurchased,
      'preview': preview,
      'thumbnail': thumbnail,
      'type': type,
      'duration': duration,
      'category': category,
      'status': status,
      'rating': rating,
      'studentsCount': studentsCount,
      'lessonsCount': lessonsCount,
      'createdAt': createdAt?.toIso8601String(),
      'lessons': lessons?.map((lesson) => lesson.toJson()).toList(),
    };
  }
}

class Lesson {
  final String? title;
  final String? content;

  Lesson({
    this.title,
    this.content,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}

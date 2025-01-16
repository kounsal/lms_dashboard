class Course {
  final String id;
  final String? title;
  final String?description;
  final double? price;
  final bool isFree;
  final double ? priceWithDiscount;
  final int discountPercent;
  final String? image;
  final String? thumbnail;
  final String? type;
  final String? link;
  final int duration;
  final String? category;
  final String? teacher;
  final int studentsCount;
  final int reviewsCount;
  final double ?rating;
  final String? status;
  final int progressPercent;
  final DateTime startDate;
  final DateTime expireOn;
  final int capacity;
  final List<String?> badges;
  final List<CourseTranslation> translations;
  final bool authHasBought;
  final bool subscriptionIncluded;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int lessonsCount;

  Course({
    required this.id,
    required this.title,
    required this.description,
     this.price,
    required this.isFree,
     this.priceWithDiscount,
    required this.discountPercent,
    required this.image,
    required this.thumbnail,
    required this.type,
    required this.link,
    required this.duration,
    required this.category,
    this.teacher,
    required this.studentsCount,
    required this.reviewsCount,
     this.rating,
    required this.status,
    required this.progressPercent,
    required this.startDate,
    required this.expireOn,
    required this.capacity,
    required this.badges,
    required this.translations,
    required this.authHasBought,
    required this.subscriptionIncluded,
    required this.createdAt,
    required this.updatedAt,
    required this.lessonsCount,
  });

  factory Course.fromJson(Map<String?, dynamic> json) {
    return Course(
      id: json['_id'] ?? '',
      title: json['title'] is String ? json['title'] : '',
      description: json['description'] is String ? json['description'] : '',
      price: json['price'],
      isFree: json['isFree'] ?? false,
      priceWithDiscount: json['priceWithDiscount'],
      discountPercent: json['discountPercent'] ?? 0,
      image: json['image'],
      thumbnail: json['thumbnail'],
      type: json['type'],
      link: json['link'],
      duration: json['duration'] ?? 0,
      category: json['category'] is String ? json['category'] : '',
      teacher: json['teacher'] is String ? json['teacher'] : '',
      studentsCount: json['studentsCount'] ?? 0,
      reviewsCount: json['reviewsCount'] ?? 0,
      rating: json['rating'],
      status: json['status'] is String ? json['status'] : '',
      progressPercent: json['progressPercent'] ?? 0,
      startDate: DateTime.parse(json['startDate'] ?? '2000-01-01'),
      expireOn: DateTime.parse(json['expireOn'] ?? '2000-01-01'),
      capacity: json['capacity'] ?? 0,
      badges: List<String>.from(json['badges'] ?? []),
      translations: (json['translations'] as List?)
          ?.map((item) => CourseTranslation.fromJson(item))
          .toList() ?? [],
      authHasBought: json['authHasBought'] ?? false,
      subscriptionIncluded: json['subscriptionIncluded'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? '2000-01-01'),
      updatedAt: DateTime.parse(json['updatedAt'] ?? '2000-01-01'),
      lessonsCount: json['lessonsCount'] ?? 0,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'price': price,
      'isFree': isFree,
      'priceWithDiscount': priceWithDiscount,
      'discountPercent': discountPercent,
      'image': image,
      'thumbnail': thumbnail,
      'type': type,
      'link': link,
      'duration': duration,
      'category': category,
      'teacher': teacher,
      'studentsCount': studentsCount,
      'reviewsCount': reviewsCount,
      'rating': rating,
      'status': status,
      'progressPercent': progressPercent,
      'startDate': startDate.toIso8601String(),
      'expireOn': expireOn.toIso8601String(),
      'capacity': capacity,
      'badges': badges,
      'translations': translations.map((translation) => translation.toJson()).toList(),
      'authHasBought': authHasBought,
      'subscriptionIncluded': subscriptionIncluded,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lessonsCount': lessonsCount,
    };
  }
}

class CourseTranslation {
  final String language;
  final String title;
  final String description;
  final String id;

  CourseTranslation({
    required this.language,
    required this.title,
    required this.description,
    required this.id,
  });

  factory CourseTranslation.fromJson(Map<String, dynamic> json) {
    return CourseTranslation(
      language: json['language'],
      title: json['title'],
      description: json['description'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'title': title,
      'description': description,
      '_id': id,
    };
  }
}

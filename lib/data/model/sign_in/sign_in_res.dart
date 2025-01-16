class SignInResponse {
  final String token;
  final User user;

  SignInResponse({required this.token, required this.user});

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String role;
  final String? college;
  final String? userClass;
  final String? state;
  final List<String>? purchasedCourses;
  final List<String>? subscriptions;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? biography;
  final String? avatar;
  final String? phone;
  final List<String>? courses;


  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.college,
    this.userClass,
    this.state,
     this.purchasedCourses,
     this.subscriptions,
    required this.createdAt,
    required this.updatedAt,
    this.biography,
    this.avatar,
    this.phone,
     this.courses,

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      college: json['college'],
      userClass: json['class'],
      state: json['state'],
      // purchasedCourses: json['purchasedCourses'] is List
      //     ? List<String>.from(json['purchasedCourses'])
      //     : json['purchasedCourses'] is Map
      //     ? []
      //     : [],

      // subscriptions: json['subscriptions'] is List
      //     ? List<String>.from(json['subscriptions'])
      //     : [],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toString()),
      biography: json['biography'],
      avatar: json['avatar'],
      phone: json['phone'],
      // courses: json['courses'] is List
      //     ? List<String>.from(json['courses'])
      //     : [],
    );
  }
}

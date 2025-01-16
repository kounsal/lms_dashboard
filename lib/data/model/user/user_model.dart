// class UserModel {
//   final String id;
//   final String name;
//   final String email;
//   final String password;
//   final String role;
//   final String? college;
//   final String? userClass;
//   final String? state;
//   final List<String> purchasedCourses;
//   final List<String> subscriptions;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String? biography;
//   final String? avatar;
//   final String? phone;
//   final List<String> courses;
//
//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.password,
//     required this.role,
//     this.college,
//     this.userClass,
//     this.state,
//     required this.purchasedCourses,
//     required this.subscriptions,
//     required this.createdAt,
//     required this.updatedAt,
//     this.biography,
//     this.avatar,
//     this.phone,
//     required this.courses,
//   });
//
//   // Factory method to create a UserModel from a JSON map
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['_id'] ?? '',  // Handle missing fields gracefully
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       password: json['password'] ?? '',
//       role: json['role'] ?? '',
//       college: json['college'],
//       userClass: json['class'],
//       state: json['state'],
//       purchasedCourses: List<String>.from(json['purchasedCourses'] ?? []),
//       subscriptions: List<String>.from(json['subscriptions'] ?? []),
//       createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
//       updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toString()),
//       biography: json['biography'],
//       avatar: json['avatar'],
//       phone: json['phone'],
//       courses: List<String>.from(json['courses'] ?? []),
//     );
//   }
//
//   // Method to convert UserModel instance to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//       'email': email,
//       'password': password,
//       'role': role,
//       'college': college,
//       'class': userClass,
//       'state': state,
//       'purchasedCourses': purchasedCourses,
//       'subscriptions': subscriptions,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//       'biography': biography,
//       'avatar': avatar,
//       'phone': phone,
//       'courses': courses,
//     };
//   }
// }
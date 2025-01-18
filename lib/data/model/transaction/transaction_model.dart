import 'package:lms_admin/data/model/course/course_content_model.dart';
import 'package:lms_admin/data/services/courseService.dart';

class TransactionHistoryResponse {
  final String message;
  final List<Transaction> transactions;

  TransactionHistoryResponse({
    required this.message,
    required this.transactions,
  });

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryResponse(
      message: json['message'],
      transactions: (json['transactions'] as List)
          .map((transaction) => Transaction.fromJson(transaction))
          .toList(),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
    };
  }
}

class Transaction {
  final String id;
  final String orderId;
  final User? user;
  final String? planId;
  final double amount;
  final String? courseId;
  final String status;
  final DateTime timestamp;
  CourseContentModel? courseDetails; // Optional field for course details

  Transaction({
    required this.id,
    required this.orderId,
    this.user,
    this.planId,
    this.courseId,
    required this.amount,
    required this.status,
    required this.timestamp,
    this.courseDetails,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'],
      orderId: json['orderId'],
      user: json['userId'] != null ? User.fromJson(json['userId']) : null,
      planId: json['planId'],
      courseId: json['courseId'],
      amount: json['amount'].toDouble(),
      status: json['status'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  static Future<Transaction> fromJsonWithCourse(
      Map<String, dynamic> json, CourseService courseService) async {
    Transaction transaction = Transaction.fromJson(json);
    if (transaction.courseId != null && transaction.courseId!.isNotEmpty) {
      try {
        transaction.courseDetails =
        await courseService.getCourseContent(transaction.courseId!);
      } catch (e) {
        // print("Failed to fetch course content for courseId: ${transaction.courseId}");
      }
    }
    return transaction;
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'orderId': orderId,
      'userId': user?.toJson(),
      'planId': planId,
      'amount': amount,
      'courseId': courseId,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
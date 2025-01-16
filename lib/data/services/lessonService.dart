import 'package:dio/dio.dart';
import 'package:lms_admin/data/model/lesson/lesson_model.dart';
import 'package:lms_admin/data/network_module.dart';

class LessonService {
  final Dio _dio = NetworkModule().getClient();

  Future<List<Lesson>> fetchAllLessons() async {
    try {
      final response = await _dio.get('/lessons/all');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((lesson) => Lesson.fromJson(lesson)).toList();
      } else {
        throw Exception("Failed to load lessons");
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        throw Exception(
            "Error: ${dioError.response?.statusMessage ?? 'Unknown error'}");
      } else {
        throw Exception("Failed to connect to server. Please try again later.");
      }
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }
}

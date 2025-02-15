import 'package:dio/dio.dart';
import 'package:lms_admin/data/model/course/course_content_model.dart';
import 'package:lms_admin/data/model/course/course_model.dart';
import 'package:lms_admin/data/network_module.dart';
import 'package:lms_admin/utils/auth_pref.dart';

class CourseService {
  final Dio _dio = NetworkModule().getClient();

  Future<List<Course>> fetchAllCourse() async {
    try {
      final response = await _dio.get('/courses/all');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((lesson) => Course.fromJson(lesson)).toList();
      } else {
        throw Exception("Failed to load Course");
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

  Future<CourseContentModel> getCourseContent(String courseId) async {
    try {
      String? token = await AuthPref.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }
      final response = await _dio.get(
        '/courses/one/$courseId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return CourseContentModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load course content");
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

  Future<void> createCourse(Map<String, dynamic> courseData) async {
    try {
      String? token = await AuthPref.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }

      final response = await _dio.post(
        '/courses/create-course',
        data: courseData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        print("Course created successfully");
        print("response $courseData");
      } else {
        throw Exception("Failed to create course");
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

  Future<void> addLesson(String courseId, Map<String, dynamic> lessonData) async {
    try {
      String? token = await AuthPref.getToken();

      print("response $lessonData");
      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }

      final response = await _dio.post(
        '/lessons/add',
        data: lessonData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("response $lessonData");


      if (response.statusCode == 201) {
        print("Lesson added successfully");
      } else {
        throw Exception("Failed to add lesson");
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        throw Exception("Error: ${dioError.response?.statusMessage ?? 'Unknown error'}");
      } else {
        throw Exception("Failed to connect to server. Please try again later.");
      }
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }

  Future<void> deleteCourse(String courseId) async {
    try {
      String? token = await AuthPref.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }

      final response = await _dio.delete(
        '/courses/$courseId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Course deleted successfully");
      } else {
        throw Exception("Failed to delete course");
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        throw Exception("Error: ${dioError.response?.statusMessage ?? 'Unknown error'}");
      } else {
        throw Exception("Failed to connect to server. Please try again later.");
      }
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }
}

import 'package:dio/dio.dart';
import 'package:lms_admin/data/model/college/college_model.dart';
import 'package:lms_admin/data/network_module.dart';
import 'package:lms_admin/utils/auth_pref.dart';

class CollegeService {
  final Dio _dio = NetworkModule().getClient();

  Future<CollegeModel> addCollege(CollegeModel college) async {
    try {
      String? token = await AuthPref.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }

      print("college.toJson() ${college.toJson()}");
      final response = await _dio.post(
        '/college/add',
        data: college.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 201) {
        return CollegeModel.fromJson(response.data);
      } else {
        throw Exception('Failed to add college');
      }
    } catch (error) {
      throw Exception('Error adding college: $error');
    }
  }

  Future<CollegeModel> getCollegeById(String collegeId) async {
    try {
      String? token = await AuthPref.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }
      final response = await _dio.get(
        '/college/$collegeId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return CollegeModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load college');
      }
    } catch (error) {
      throw Exception('Error fetching college: $error');
    }
  }

  // Get all colleges
  Future<List<CollegeModel>> getAllColleges() async {
    try {
      String? token = await AuthPref.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }
      final response = await _dio.get(
        '/college/all',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((item) => CollegeModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load all colleges');
      }
    } catch (error) {
      throw Exception('Error fetching all colleges: $error');
    }
  }

  // Delete college by ID
  Future<void> deleteCollege(String collegeId) async {
    try {
      String? token = await AuthPref.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }
      final response = await _dio.delete(
        '/college/$collegeId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete college');
      }
    } catch (error) {
      throw Exception('Error deleting college: $error');
    }
  }
}
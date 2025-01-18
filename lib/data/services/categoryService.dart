import 'package:dio/dio.dart';
import 'package:lms_admin/data/model/category/category_model.dart';
import 'package:lms_admin/data/network_module.dart';
import 'package:lms_admin/utils/auth_pref.dart';

class CategoryService {
  final Dio _dio = NetworkModule().getClient();

  Future<CategoryModel> addCategory(CategoryModel category) async {
    try {
      String? token = await AuthPref.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }
      final response = await _dio.post(
        '/category/add',
        data: category.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 201) {
        return CategoryModel.fromJson(response.data);
      } else {
        throw Exception('Failed to add category');
      }
    } catch (error) {
      throw Exception('Error adding category: $error');
    }
  }

  Future<CategoryModel> getCategoryById(String categoryId) async {
    try {
      String? token = await AuthPref.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }
      final response = await _dio.get(
        '/category/$categoryId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return CategoryModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load category');
      }
    } catch (error) {
      throw Exception('Error fetching category: $error');
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      String? token = await AuthPref.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }
      final response = await _dio.get(
        '/category/all',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((item) => CategoryModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load all categories');
      }
    } catch (error) {
      throw Exception('Error fetching all categories: $error');
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      String? token = await AuthPref.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }
      final response = await _dio.delete(
        '/category/$categoryId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to delete category');
      }
    } catch (error) {
      throw Exception('Error deleting category: $error');
    }
  }
}
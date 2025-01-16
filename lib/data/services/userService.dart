import 'package:dio/dio.dart';
import 'package:lms_admin/data/model/sign_in/sign_in_res.dart';
import 'package:lms_admin/data/network_module.dart';
import 'package:lms_admin/utils/auth_pref.dart';


class UserService {
  final Dio _dio = NetworkModule().getClient();

  Future<List<User>> getAllUsers() async {
    try {
      final response = await _dio.get('/auth/admin/get-all-users');

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> usersJson = response.data['users'];

        return usersJson.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch users: ${response.statusMessage}');
      }
    } catch (error) {
      if (error is DioError) {
        throw Exception('Dio error: ${error.message}');
      } else {
        throw Exception('Unexpected error: $error');
      }
    }
  }

  Future<void> registerInstructor({
    required String name,
    required String email,
    required String password,
    required String biography,
    // required String avatar,
    required String phone,
    required String state,
  }) async {
    final String? token = await AuthPref.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('No token found. Please log in.');
    }

    try {
      final response = await _dio.post(
        '/auth/register-instructor',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
        data: {
          "name": name,
          "email": email,
          "password": password,
          "biography": biography,
          // "avatar": avatar,
          "phone": phone,
          "state": state,
        },
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to register instructor: ${response.statusMessage}');
      }
    } catch (error) {
      if (error is DioError) {
        throw Exception('Dio error: ${error.message}');
      } else {
        throw Exception('Unexpected error: $error');
      }
    }
  }
}

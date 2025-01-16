import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lms_admin/data/model/sign_in/sign_in_req.dart';
import 'package:lms_admin/data/model/sign_in/sign_in_res.dart';
import 'package:lms_admin/data/network_module.dart';


class AuthService {
  final Dio _dio = NetworkModule().getClient();

  Future<SignInResponse> signIn(SignInRequest request) async {
    try {
      final response = await _dio.post('/auth/login', data: request.toJson());

      if (response.data is String) {
        var decodedResponse = jsonDecode(response.data);
        return SignInResponse.fromJson(decodedResponse);
      } else {
        return SignInResponse.fromJson(response.data); // If it's already a Map, pass it directly
      }    } on DioError catch (dioError) {
      if (dioError.response != null) {
        final statusCode = dioError.response!.statusCode;

        if (statusCode == 400) {
          throw Exception("Invalid credentials. Please try again.");
        } else if (statusCode == 404) {
          throw Exception("Server not found. Please check your connection.");
        } else {
          throw Exception(
              "Something went wrong: ${dioError.response?.statusMessage ?? 'Unknown error'}");
        }
      } else {
        throw Exception("Failed to connect to the server. Please try again later.");
      }
    } catch (error) {
      throw Exception("An unexpected error occurred: $error");
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      final response = await _dio.delete('/auth/admin/delete-user/$userId');
      if (response.statusCode == 200) {
        print("User deleted successfully");
      } else {
        throw Exception('Failed to delete user');
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        final statusCode = dioError.response!.statusCode;
        throw Exception('Error ${statusCode}: ${dioError.response?.statusMessage}');
      } else {
        throw Exception("Failed to connect to the server.");
      }
    } catch (error) {
      throw Exception("An unexpected error occurred: $error");
    }
  }

}

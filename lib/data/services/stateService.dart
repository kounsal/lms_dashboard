import 'package:dio/dio.dart';
import 'package:lms_admin/data/model/state/state_model.dart';
import 'package:lms_admin/data/network_module.dart';
import 'package:lms_admin/utils/auth_pref.dart';

class StateService {
  final Dio _dio = NetworkModule().getClient();

  Future<StateModel> addState(StateModel state) async {
    try {
      String? token = await AuthPref.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }
      final response = await _dio.post(
        '/state/add',
        data: state.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 201) {
        return StateModel.fromJson(response.data);
      } else {
        throw Exception('Failed to add state');
      }
    } catch (error) {
      throw Exception('Error adding state: $error');
    }
  }

  Future<StateModel> getStateById(String stateId) async {
    try {
      String? token = await AuthPref.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }
      final response = await _dio.get(
        '/state/$stateId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return StateModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load state');
      }
    } catch (error) {
      throw Exception('Error fetching state: $error');
    }
  }

  Future<List<StateModel>> getAllStates() async {
    try {
      String? token = await AuthPref.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }
      final response = await _dio.get(
        '/state/all',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((item) => StateModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load all states');
      }
    } catch (error) {
      throw Exception('Error fetching all states: $error');
    }
  }

  Future<void> deleteState(String stateId) async {
    try {
      String? token = await AuthPref.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }
      final response = await _dio.delete(
        '/state/$stateId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete state');
      }
    } catch (error) {
      throw Exception('Error deleting state: $error');
    }
  }
}
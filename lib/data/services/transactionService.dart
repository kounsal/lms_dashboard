import 'package:dio/dio.dart';
import 'package:lms_admin/data/model/transaction/transaction_model.dart';
import 'package:lms_admin/data/network_module.dart';
import 'package:lms_admin/utils/auth_pref.dart';

class TransactionService {
  final Dio _dio = NetworkModule().getClient();

  Future<TransactionHistoryResponse> fetchTransactionHistory() async {
    try {
      String? token = await AuthPref.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }
      final response = await _dio.get(
        '/razorpay/admin/transactions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return TransactionHistoryResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (error) {
      // Handle the error accordingly
      throw Exception('Error fetching transaction history: $error');
    }
  }
}

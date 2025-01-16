import 'package:dio/dio.dart';
import 'package:lms_admin/data/network_module.dart';
import 'package:lms_admin/data/services/transactionService.dart';

class TransactionController {
  final Dio _dio = NetworkModule().getClient();

  final TransactionService transactionService = TransactionService();

  Future<List<double>> getMonthlyRevenue() async {
    final List<double> monthlyRevenue = List.filled(12, 0.0);

    try {

        final data = await transactionService.fetchTransactionHistory();


        for (var transaction in data.transactions) {
        // print("data ${transaction.amount}, ${transaction.timestamp}");
          String timestampString = transaction.timestamp.toIso8601String();
          if (timestampString.isNotEmpty) {
            DateTime timestamp = DateTime.parse(timestampString);
            int monthIndex = timestamp.month - 1;
            monthlyRevenue[monthIndex] += transaction.amount;
          }
        }

        return monthlyRevenue;

    } catch (error) {
      throw Exception('Error fetching transaction history: $error');
    }
  }
}

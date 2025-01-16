import 'package:get/get.dart';
import 'package:lms_admin/data/model/transaction/transaction_model.dart';
import 'package:lms_admin/data/services/courseService.dart';
import 'package:lms_admin/data/services/transactionService.dart';

class LastTransactionController extends GetxController {
  var transactions = <Transaction>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final TransactionService _transactionService = TransactionService();
  final CourseService _courseService = CourseService();


  @override
  void onInit() {
    super.onInit();
    fetchTransactionHistory();
  }

  Future<void> fetchTransactionHistory() async {
    try {
      isLoading(true);
      final response = await _transactionService.fetchTransactionHistory();

      final updatedTransactions = await Future.wait(
        response.transactions.map((transaction) async {
          return await Transaction.fromJsonWithCourse(transaction.toJson(), _courseService);
        }),
      );

      transactions.value = updatedTransactions;

      transactions.value.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      transactions.value = transactions.take(5).toList();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}

import 'package:get/get.dart';
import 'package:lms_admin/data/model/transaction/transaction_model.dart';
import 'package:lms_admin/data/services/transactionService.dart';
import 'package:lms_admin/data/services/courseService.dart';

class AllTransactionController extends GetxController {
  var transactions = <Transaction>[].obs;
  var filteredTransactions = <Transaction>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var searchQuery = ''.obs;

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

      transactions.value = await Future.wait(
        response.transactions.map((transaction) =>
            Transaction.fromJsonWithCourse(transaction.toJson(), _courseService),
        ),
      );

      filteredTransactions.value = transactions.toList();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  void filterTransactions(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredTransactions.value = transactions.toList();
    } else {
      filteredTransactions.value = transactions.where((transaction) {
        return transaction.user?.name.toLowerCase().contains(query.toLowerCase()) ??
            false ||
                transaction.orderId.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }
}

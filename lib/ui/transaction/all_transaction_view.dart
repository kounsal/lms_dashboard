import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms_admin/ui/transaction/all_transaction_controller.dart';

class AllTransactionView extends StatelessWidget {
  final AllTransactionController controller = Get.put(AllTransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                hintText: 'Search by order ID or user name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: controller.filterTransactions,
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Expanded(flex: 1, child: Text('User', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text('Order Id', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 3, child: Text('User Info', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text('CourseId', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Transaction List Section
            Obx(() {
              if (controller.isLoading.value) {
                return Expanded(child: Center(child: CircularProgressIndicator()));
              } else if (controller.filteredTransactions.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      "No Transactions found",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = controller.filteredTransactions[index];
                      // print("objecssssssssssst ${transaction.courseDetails?.title}");

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Expanded(
                              //   flex: 1,
                              //   child: Align(
                              //     alignment: Alignment.topLeft,
                              //     child: CircleAvatar(
                              //       radius: 30,
                              //       backgroundImage: null,
                              //       child: Icon(Icons.person, size: 30),
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                flex: 2,
                                child: Text(transaction.orderId, style: TextStyle(fontSize: 14)),
                              ),

                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(transaction.user?.name ?? 'User not available', style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 8),
                                    Text(transaction.user?.email ?? '', style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(transaction.courseDetails?.title ?? "No CourseId", style: TextStyle(fontSize: 14)),
                              ),

                              // Amount Section
                              Expanded(
                                flex: 1,
                                child: Text('\$${transaction.amount ?? 0.0}', style: TextStyle(fontSize: 14)),
                              ),

                              // Status Section
                              Expanded(
                                flex: 1,
                                child: Text(
                                  transaction.status,
                                  style: TextStyle(
                                    color: transaction.status == 'paid' ? Colors.green : Colors.red[700],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('dd MMM yyyy').format(transaction.timestamp),
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      DateFormat('hh:mm a').format(transaction.timestamp),
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms_admin/ui/transaction/last_transaction_controller.dart';

class TransactionHistoryView extends StatelessWidget {
  final LastTransactionController controller = Get.put(LastTransactionController());

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 400,
      // width: MediaQuery.of(context).size.width * 0.4,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            if (controller.errorMessage.isNotEmpty) {
              return Center(child: Text('Error: ${controller.errorMessage.value}'));
            }

            if (controller.transactions.isEmpty) {
              return Center(child: Text('No transactions found.'));
            }

            return ListView.builder(
              itemCount: controller.transactions.length,
              itemBuilder: (context, index) {
                final transaction = controller.transactions[index];

                // return Card(
                //   margin: EdgeInsets.symmetric(vertical: 8.0),
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Order ID: ${transaction.orderId}',
                //           style: TextStyle(fontWeight: FontWeight.bold),
                //         ),
                //         SizedBox(height: 8),
                //         Text('Amount: \$${transaction.amount.toStringAsFixed(2)}'),
                //         SizedBox(height: 8),
                //         Text('Status: ${transaction.status}'),
                //         SizedBox(height: 8),
                //         Text('Timestamp: ${transaction.timestamp}'),
                //       ],
                //     ),
                //   ),
                // );
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            // color: Colors.yellow,
                            child: CircleAvatar(
                                radius: 30,
                                backgroundImage:null,
                                child: Icon(Icons.person, size: 30)
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(transaction.user?.name ?? 'user is not available', style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text(transaction.user?.email  ?? '', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(transaction.courseDetails?.title ?? "No CourseId", style: TextStyle(fontSize: 14)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('\$${transaction.amount ?? 0.0}', style: TextStyle(fontSize: 14)),
                        ),

                        Expanded(
                          flex: 1,
                          child: Text(
                            transaction.status ,
                            style: TextStyle(
                              color:  transaction.status == 'paid' ? Colors.green : Colors.red[700],
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
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                DateFormat('hh:mm a').format(transaction.timestamp),
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        )

                        // Expanded(
                        //   flex: 1,
                        //   child: Text(transaction.timestamp ?? 'Unknown', style: TextStyle(fontSize: 14)),
                        // ),
                        // Expanded(
                        //   flex: 1,
                        //   child: Row(
                        //     children: [
                        //       Icon(Icons.star, color: Colors.green, size: 20),
                        //       SizedBox(width: 2),
                        //       Text('${course.rating ?? 0.0}', style: TextStyle(fontSize: 16)),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
    );
  }
}

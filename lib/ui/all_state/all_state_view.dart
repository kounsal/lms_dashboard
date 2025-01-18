import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/ui/all_state/all_state_controller.dart';

class AllStateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AllStateController stateController = Get.put(AllStateController());

    return Scaffold(
      backgroundColor: Colors.green.withOpacity(0.1),

      body: Obx(() {
        if (stateController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (stateController.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${stateController.errorMessage.value}', style: TextStyle(fontSize: 16, color: Colors.red)));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text(
                'All States',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // color: Colors.blueAccent,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: stateController.states.length,
                itemBuilder: (context, index) {
                  final state = stateController.states[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(Icons.flag, size: 50, color: Colors.green.withOpacity(0.5)),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Code: ${state.code}',
                                  style: TextStyle(fontSize: 14, color: Colors.green[800]),
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Icon(
                                  state.status == true ? Icons.check_circle : Icons.cancel,
                                  color: state.status == true ? Colors.green : Colors.red,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  state.status == true ? 'Active' : 'Inactive',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

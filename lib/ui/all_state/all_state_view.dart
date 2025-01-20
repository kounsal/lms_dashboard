import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/data/model/state/state_model.dart';
import 'package:lms_admin/data/services/stateService.dart';
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
                                stateController.deleteState( state.id!);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddStateDialog(context, stateController);
        },
        backgroundColor: Colors.green.withOpacity(0.6),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddStateDialog(BuildContext context, AllStateController stateController) {
    final nameController = TextEditingController();
    final codeController = TextEditingController();
    bool isActive = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add State'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: codeController,
                    decoration: InputDecoration(labelText: 'Code'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Active Status'),
                      Switch(
                        value: isActive,
                        onChanged: (value) {
                          setState(() {
                            isActive = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final name = nameController.text.trim();
                    final code = codeController.text.trim();

                    if (name.isEmpty || code.isEmpty) {
                      Get.snackbar('Error', 'Please fill in all fields');
                      return;
                    }

                    final newState = StateModel(
                      name: name,
                      code: code,
                      status: isActive,
                    );

                    try {
                      final addedState = await StateService().addState(newState);
                      stateController.states.add(addedState);
                      Navigator.pop(context);
                      Get.snackbar('Success', 'State added successfully');
                    } catch (e) {
                      Navigator.pop(context);
                      Get.snackbar('Error', 'Failed to add state: $e');
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

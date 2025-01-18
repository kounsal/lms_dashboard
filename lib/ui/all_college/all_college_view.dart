import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/ui/all_college/all_college_controller.dart';

class CollegeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CollegeController collegeController = Get.put(CollegeController());

    return Scaffold(
      backgroundColor: Colors.green.withOpacity(0.1),

      body: Obx(() {
        if (collegeController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // If there is an error, show the error message
        if (collegeController.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${collegeController.errorMessage.value}', style: TextStyle(fontSize: 16, color: Colors.red)));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'All Colleges',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      // color: Colors.blueAccent,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => collegeController.addCollege(context),
                      color: Colors.teal,
                      icon: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: collegeController.colleges.length,
                itemBuilder: (context, index) {
                  final college = collegeController.colleges[index];
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
                          Icon(Icons.school, size: 50, color: Colors.green.withOpacity(0.5)),
                          SizedBox(width: 12),
                          // College details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  college.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'State: ${college.state?.name}',
                                  style: TextStyle(fontSize: 14, color: Colors.black54),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Region: ${college.region}',
                                  style: TextStyle(fontSize: 14, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          // Trailing Icon for navigation
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
                            onPressed: () {
                              // Handle navigation or action here
                            },
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

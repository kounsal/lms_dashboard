import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/ui/student/student_controller.dart';

class StudentView extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or email',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: controller.filterStudents,
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 1, child: Text('Picture', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 3, child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Actions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Obx(() {
              if (controller.isLoading.value) {
                return Expanded(child: Center(child: CircularProgressIndicator()));
              } else if (controller.students.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      "No Students found",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.students.length,
                    itemBuilder: (context, index) {
                      final student = controller.students[index];
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
                                  alignment: Alignment.topLeft,
                                  // color: Colors.yellow,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage:null,
                                    child: Icon(Icons.person, size: 30)
                                  ),
                                ),
                              ),
                              Expanded(flex: 2, child: Text(student.name ?? '-')),
                              Expanded(flex: 3, child: Text(student.email ?? '-')),
                              Expanded(
                                flex: 2,
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    controller.deleteStudent(student.id!);
                                  },
                                ),
                              ),
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

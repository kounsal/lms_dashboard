import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/ui/all_instructor/all_instructor_controller.dart';

class InstructorView extends StatelessWidget {
  final InstructorController controller = Get.put(InstructorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instructor Management',
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
              onChanged: controller.filterInstructors,
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
                  Expanded(flex: 3, child: Text('Info', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text('State', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text('Phone', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                    flex: 1,
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
              } else if (controller.instructors.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      "No Instructors found",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.instructors.length,
                    itemBuilder: (context, index) {
                      final instructor = controller.instructors[index];
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
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: null,
                                    child: Icon(Icons.person, size: 30),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(instructor.name ?? '-', style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 4),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Text(instructor.biography ?? '-',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(flex: 1, child: Text(instructor.state ?? '-')),
                              Expanded(flex: 2, child: Text(instructor.email ?? '-')),
                              Expanded(flex: 2, child: Text(instructor.phone ?? '-')),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    controller.deleteInstructor(instructor.id);
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

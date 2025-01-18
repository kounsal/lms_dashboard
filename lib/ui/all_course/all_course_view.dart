import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/ui/all_course/all_course_controller.dart';
import 'package:lms_admin/ui/course_details/course_details_view.dart';

class CourseView extends StatelessWidget {
  final CourseController controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            // Header Row
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
                  Expanded(flex: 1, child: Text('Thumbnail', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 3, child: Text('Course', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text('Rating', style: TextStyle(fontWeight: FontWeight.bold))),
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
              } else if (controller.courses.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      "No Courses found",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.courses.length,
                    itemBuilder: (context, index) {
                      final course = controller.courses[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the Course Details Page
                          Get.to(() => CourseContentView(courseId: course.id!));
                        },
                        child: Card(
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
                                      backgroundColor: Colors.grey,
                                      child: Icon(Icons.book, size: 30),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(course.title ?? 'No title', style: TextStyle(fontWeight: FontWeight.bold)),
                                      SizedBox(height: 8),
                                      Text(course.description ?? 'No description available', style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('\$${course.price ?? 0.0}', style: TextStyle(fontSize: 14)),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    course.isFree ?? true ? 'Free' : 'Paid',
                                    style: TextStyle(
                                      color: course.isFree ?? true ? Colors.grey : Colors.yellow[700],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(course.type ?? 'Unknown', style: TextStyle(fontSize: 14)),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.green, size: 20),
                                      SizedBox(width: 2),
                                      Text('${course.rating ?? 0.0}', style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      controller.deleteCourse(course.id!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                ;
              }
            }),
          ],
        ),
      ),
    );
  }
}

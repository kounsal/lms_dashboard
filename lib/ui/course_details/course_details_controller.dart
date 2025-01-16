import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/data/model/course/course_content_model.dart';
import 'package:lms_admin/data/services/courseService.dart';

class CourseContentController extends GetxController {
  final CourseService _courseService = CourseService();
  var isLoading = true.obs;
  var courseContent = Rxn<CourseContentModel>();

  Future<void> fetchCourseContent(String courseId) async {
    try {
      isLoading.value = true;
      courseContent.value = await _courseService.getCourseContent(courseId);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void showAddLessonDialog(String courseId) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    final durationController = TextEditingController();

    // Variable to store selected type
    String? selectedType;

    Get.dialog(
      AlertDialog(
        title: Text('Add New Lesson', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(Get.context!).size.width / 6, // 1/6th of screen width
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Lesson Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1, color: Colors.teal),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            Container(
              width: MediaQuery.of(Get.context!).size.width / 6,
              child: DropdownButton<String>(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                isExpanded: true,
                value: selectedType,
                hint: const Text('Select Type'),
                items: const [
                  DropdownMenuItem(value: 'video', child: Text('Video')),
                  DropdownMenuItem(value: 'document', child: Text('Document')),
                ],
                onChanged: (value) {
                  selectedType = value;
                },
                underline: SizedBox(), // Remove the default underline
                icon: Icon(Icons.arrow_drop_down, color: Colors.teal),
                style: TextStyle(color: Colors.black),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.teal, width: 1),
                //   borderRadius: BorderRadius.circular(8),
                // ),
              ),
            ),
            SizedBox(height: 10),

            // Lesson Content (URL) TextField with a thin border and fixed width
            Container(
              width: MediaQuery.of(Get.context!).size.width / 6,
              child: TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: 'Lesson Content (URL)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1, color: Colors.teal),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Duration TextField with a thin border and fixed width
            Container(
              width: MediaQuery.of(Get.context!).size.width / 6,
              child: TextField(
                controller: durationController,
                decoration: InputDecoration(
                  labelText: 'Duration (hours)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1, color: Colors.teal),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          // Cancel Button
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),

          // Add Button with custom style
          ElevatedButton(
            onPressed: () {
              final title = titleController.text;
              final type = selectedType;
              final content = contentController.text;
              final durationText = durationController.text;

              // Print for debugging
              print("Selected Type: $selectedType");

              // Validate that duration is a valid number
              if (title.isNotEmpty && type != null && content.isNotEmpty && durationText.isNotEmpty) {
                if (double.tryParse(durationText) == null) {
                  // If duration is not a valid number
                  Get.snackbar('Error', 'Please enter a valid number for Duration.',
                      snackPosition: SnackPosition.BOTTOM);
                  return;
                }

                // Proceed with adding the lesson
                _courseService.addLesson(courseId, {
                  'title': title,
                  'type': type,
                  'content': content,
                  'duration': durationText, // Keep as string
                  'courseId': courseId,
                }).then((_) {
                  Get.back();
                  Get.snackbar('Success', 'Lesson added successfully',
                      snackPosition: SnackPosition.BOTTOM);
                  fetchCourseContent(courseId); // Refresh course content
                }).catchError((e) {
                  print(e);
                  Get.snackbar('Error', e.toString(),
                      snackPosition: SnackPosition.BOTTOM);
                });
              } else {
                // Show error if any field is empty
                Get.snackbar('Error', 'Please fill all fields.',
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.withOpacity(0.3),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Add'),
          )

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/data/services/courseService.dart';
import 'package:lms_admin/ui/course_details/course_details_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseContentView extends StatelessWidget {
  final String courseId;

  CourseContentView({required this.courseId});

  @override
  Widget build(BuildContext context) {
    final CourseContentController controller = Get.put(CourseContentController());

    controller.fetchCourseContent(courseId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Course Content',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final courseContent = controller.courseContent.value;

        if (courseContent == null) {
          return Center(child: Text('No content available.'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          courseContent.title ?? 'Untitled Course',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[800], // Title color
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.circle,
                        color: courseContent.status == 'active' ? Colors.green : Colors.grey,
                        size: 12,
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      courseContent.description ?? 'No description available.',
                      style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.video_camera_front,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Type: ${courseContent.type ?? 'Not Specified'}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                            size: 24,
                          ),
                          SizedBox(width: 5),
                          Text(
                            courseContent.rating?.toStringAsFixed(1) ?? '0.0',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.yellow[700]
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),


                ],
              ),

              SizedBox(height: 10),

              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => controller.showAddLessonDialog(courseId),
                  color: Colors.teal,
                  icon: Icon(Icons.add),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Course Details',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[800],
                              ),
                            ),
                            SizedBox(height: 16),
                            _buildCourseDetailRow('Price:', '\$${courseContent.price}'),
                            _buildCourseDetailRow('Teacher:', courseContent.teacher!),
                            _buildCourseDetailRow('Type:', courseContent.type!),
                            _buildCourseDetailRow('Duration:', '${courseContent.duration} hours'),
                            _buildCourseDetailRow('Category:', courseContent.category!),
                            _buildCourseDetailRow('Status:', courseContent.status!),
                            _buildCourseDetailRow('Rating:', courseContent.rating.toString()),
                            _buildCourseDetailRow('Students Enrolled:', courseContent.studentsCount.toString()),
                            _buildCourseDetailRow('Lessons Count:', courseContent.lessonsCount.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Lessons Section with fixed size and scrolling
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lessons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Container(
                            height: 340,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ...courseContent.lessons?.map((lesson) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          if (Uri.tryParse(lesson.content ?? '')?.hasAbsolutePath ?? false) {
                                            final uri = Uri.parse(lesson.content!);
                                            if (await canLaunchUrl(uri)) {
                                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                                            } else {
                                              Get.snackbar(
                                                'Error',
                                                'Unable to open link',
                                                backgroundColor: Colors.red.withOpacity(0.5),
                                              );
                                            }
                                          } else {
                                            Get.snackbar(
                                              'Invalid Content',
                                              'This lesson does not contain a valid URL.',
                                              backgroundColor: Colors.red.withOpacity(0.5),
                                            );
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                blurRadius: 5,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.play_circle_fill, color: Colors.teal, size: 24),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      lesson.title ?? 'Untitled Lesson',
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      lesson.content ?? 'No content available.',
                                                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList() ?? [],
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        );
      }),
    );
  }

  Widget _buildCourseDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.teal[700]),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

}

import 'package:get/get.dart';
import 'package:lms_admin/data/model/course/course_model.dart';
import 'package:lms_admin/data/services/courseService.dart';

class CourseController extends GetxController {
  var courses = <Course>[].obs;
  var filteredCourses = <Course>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;

  final CourseService courseService = CourseService();

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      isLoading(true);
      var coursesList = await courseService.fetchAllCourse();
      courses.value = coursesList;
      filteredCourses.value = coursesList;
    } finally {
      isLoading(false);
    }
  }

  void filterCourses(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredCourses.value = courses;
    } else {
      filteredCourses.value = courses.where((course) {
        return course.title!.toLowerCase().contains(query.toLowerCase()) ||
            course.description!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  Future<void> deleteCourse(String courseId) async {
    try {
      isLoading(true);
      await courseService.deleteCourse(courseId);
      courses.removeWhere((course) => course.id == courseId);
      filteredCourses.removeWhere((course) => course.id == courseId);
      Get.snackbar('Success', 'Course deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete course: $e');
    } finally {
      isLoading(false);
    }
  }
}

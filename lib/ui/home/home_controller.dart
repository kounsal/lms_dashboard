import 'package:get/get.dart';
import 'package:lms_admin/data/services/courseService.dart';
import 'package:lms_admin/data/services/lessonService.dart';
import 'package:lms_admin/data/services/userService.dart';
import 'package:lms_admin/ui/all_instructor/all_instructor_controller.dart';
import 'package:lms_admin/ui/student/student_controller.dart';

class HomeController extends GetxController {
  RxInt totalUsersCount = 0.obs;
  RxInt totalInstructorCount = 0.obs;
  RxInt totalStudentCount = 0.obs;
  RxInt totalCoursesCount = 0.obs;
  RxInt totalLessonsCount = 0.obs;

  final LessonService lessonService = LessonService();
  final UserService _userService = UserService();
  final CourseService courseService = CourseService();

  final StudentController studentController = Get.find<StudentController>();
  final InstructorController instructorController = Get.find<InstructorController>();


  @override
  void onInit() {
    super.onInit();
    fetchLessonsCount();
    fetchCourseCount();
    fetchUsersCount();
  }

  Future<void> fetchLessonsCount() async {
    try {
      final lessons = await lessonService.fetchAllLessons();
      totalLessonsCount.value = lessons.length;
    } catch (e) {
      print("Error fetching lessons: $e");
    }
  }
  Future<void> fetchCourseCount() async {
    try {
      final course = await courseService.fetchAllCourse();
      totalCoursesCount.value = course.length;
    } catch (e) {
      print("Error fetching course: $e");
    }
  }

  Future<void> fetchUsersCount() async {
    try {
      final allUsers = await _userService.getAllUsers();
      totalUsersCount.value = allUsers.length;
      totalStudentCount.value = allUsers.where((user) => user.role == 'student').length;
      totalInstructorCount.value = allUsers.where((user) => user.role == 'instructor').length;
    } catch (e) {
      print("Error fetching users: $e");
    }
  }
}

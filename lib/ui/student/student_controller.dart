import 'package:get/get.dart';
import 'package:lms_admin/data/model/sign_in/sign_in_res.dart';
import 'package:lms_admin/data/services/authService.dart';
import 'package:lms_admin/data/services/userService.dart';

class StudentController extends GetxController {
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  var students = <User>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }

  void fetchStudents() async {
    try {
      isLoading.value = true;
      final allUsers = await _userService.getAllUsers();
      students.value = allUsers.where((user) => user.role == 'student').toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch students: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filterStudents(String query) {
    searchQuery.value = query;
    if (query.isNotEmpty) {
      students.value = students
          .where((student) =>
      (student.name?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
          (student.email?.toLowerCase().contains(query.toLowerCase()) ?? false))
          .toList();
    } else {
      fetchStudents();
    }
  }

  void deleteStudent(String userId) async {
    try {
      isLoading.value = true;
      await _authService.deleteUser(userId);
      students.removeWhere((student) => student.id == userId);
      Get.snackbar('Success', 'Student deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete student: $e');
    }finally{
      isLoading.value = false;
    }
  }

}

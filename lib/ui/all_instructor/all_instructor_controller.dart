import 'package:get/get.dart';
import 'package:lms_admin/data/model/sign_in/sign_in_res.dart';
import 'package:lms_admin/data/services/authService.dart';
import 'package:lms_admin/data/services/userService.dart';

class InstructorController extends GetxController {
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  var instructors = <User>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInstructors();
  }

  void fetchInstructors() async {
    try {
      isLoading.value = true;
      final allUsers = await _userService.getAllUsers();
      instructors.value = allUsers.where((user) => user.role == 'instructor').toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch instructors: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filterInstructors(String query) {
    searchQuery.value = query;
    if (query.isNotEmpty) {
      instructors.value = instructors
          .where((instructor) =>
      (instructor.name?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
          (instructor.email?.toLowerCase().contains(query.toLowerCase()) ?? false))
          .toList();
    } else {
      fetchInstructors();
    }
  }

  void deleteInstructor(String userId) async {
    try {
      isLoading.value = true;
      await _authService.deleteUser(userId);
      instructors.removeWhere((student) => student.id == userId);
      Get.snackbar('Success', 'Student deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete student: $e');
    }finally{
      isLoading.value = false;
    }
  }
}

import 'package:get/get.dart';
import 'package:lms_admin/data/services/userService.dart';
import 'package:lms_admin/ui/all_instructor/all_instructor_controller.dart';

class AddInstructorController extends GetxController {
  final UserService _userService = UserService();
  final InstructorController _instructorController = Get.find<InstructorController>();


  var isLoading = false.obs;

  Future<void> addInstructor({
    required String name,
    required String email,
    required String password,
    required String biography,
    // required String avatar,
    required String phone,
    required String state,
  }) async {
    String? validationError = _validateFields(
      name: name,
      email: email,
      password: password,
      biography: biography,
      phone: phone,
      state: state,
    );

    if (validationError != null) {
      Get.snackbar('Validation Error', validationError);
      return;
    }

    isLoading.value = true;
    try {
      await _userService.registerInstructor(
        name: name,
        email: email,
        password: password,
        biography: biography,
        // avatar: avatar,
        phone: phone,
        state: state,
      );
      Get.snackbar('Success', 'Instructor registered successfully');
      _instructorController.fetchInstructors();
    } catch (error) {
      Get.snackbar('Error', error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  String? _validateFields({
    required String name,
    required String email,
    required String password,
    required String biography,
    required String phone,
    required String state,
  }) {
    if (name.trim().isEmpty) return 'Name is required';
    if (email.trim().isEmpty) return 'Email is required';
    if (!_isValidEmail(email)) return 'Invalid email format';
    if (password.trim().isEmpty) return 'Password is required';
    if (password.trim().length < 6) return 'Password must be at least 6 characters';
    if (biography.trim().isEmpty) return 'Biography is required';
    if (phone.trim().isEmpty) return 'Phone number is required';
    if (!_isValidPhoneNumber(phone)) return 'Invalid phone number format';
    if (state.trim().isEmpty) return 'State is required';
    return null;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    return phoneRegex.hasMatch(phone);
  }
}

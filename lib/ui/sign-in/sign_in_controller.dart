import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/data/model/sign_in/sign_in_req.dart';
import 'package:lms_admin/data/model/sign_in/sign_in_res.dart';
import 'package:lms_admin/data/services/authService.dart';
import 'package:lms_admin/ui/dashboard/dashboard_view.dart';
import 'package:lms_admin/utils/auth_pref.dart';


class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;

  final AuthService _authService = AuthService();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signIn() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        final request = SignInRequest(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        final SignInResponse response = await _authService.signIn(request);
        await AuthPref.saveToken(response.token);

        Get.snackbar(
          "Success",
          "Logged in successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAll(() => DashboardView());

        print("Token: ${response.token}");
        // print("User Name: ${response.user.name}");

      } catch (error) {
        print("er $error");
        Get.snackbar(
          "Error",
          "Failed to sign in: ${error}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Please fill in all fields.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

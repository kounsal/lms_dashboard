import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms_admin/data/model/sign_in/generate_code_req.dart';
import 'package:lms_admin/data/model/sign_in/sign_in_req.dart';
import 'package:lms_admin/data/model/sign_in/sign_in_res.dart';
import 'package:lms_admin/data/services/authService.dart';
import 'package:lms_admin/ui/dashboard/dashboard_view.dart';
import 'package:lms_admin/utils/auth_pref.dart';
import 'package:http/http.dart' as http;

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isLoading = false.obs;
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

  Future<void> generateCode() async {
    final String? token = await AuthPref.getToken();

    if (emailController.text.isNotEmpty) {
      try {
        isLoading.value = true;
        var request = await http.post(
            Uri.parse(
                "https://lms-backend-gc2i.onrender.com/api/auth/admin/generate-code"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(
                GenerateCodeReq(email: emailController.text).toJson()));
        if (request.statusCode == 200) {
          var body = jsonDecode(request.body);
          Get.dialog(
            AlertDialog(
              title: const Text("ACCESS CODE GENERATED!"),
              content: Text("Access Code : ${body['code']}"),
              actions: [
                TextButton(
                    onPressed: () async {
                      try {
                        await Clipboard.setData(
                            ClipboardData(text: body['code']));
                        Get.snackbar("Success!", 'Copied to Clipboard!');
                      } catch (e) {
                        print(e);
                        Get.snackbar("Error", 'Failed to copy to clipboard.');
                      }
                    },
                    child: Text("Copy Code"))
              ],
            ),

            //   AboutDialog(
            //   children: [
            //     Text("Access Code : ${body['code']}")
            //   ],
            // )
          );
        } else {
          print(request.body);
          throw Exception("Server Error");
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Failed to Generate Code $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}

import 'package:get/get.dart';
import 'package:lms_admin/ui/dashboard/dashboard_view.dart';
import 'package:lms_admin/ui/sign-in/sign_In_view.dart';
import 'package:lms_admin/utils/auth_pref.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await AuthPref.getToken();
    if (token != null && token.isNotEmpty) {
      Get.off(() => DashboardView());
    } else {
      Get.off(() => SignInView());
    }
  }
}

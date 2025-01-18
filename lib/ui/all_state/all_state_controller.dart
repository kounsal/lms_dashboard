import 'package:get/get.dart';
import 'package:lms_admin/data/model/state/state_model.dart';
import 'package:lms_admin/data/services/stateService.dart';

class AllStateController extends GetxController {
  var states = <StateModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchColleges();
  }

  Future<void> fetchColleges() async {
    try {
      isLoading(true);
      states.value = await StateService().getAllStates();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}

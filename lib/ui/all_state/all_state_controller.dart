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
    fetchStates();
  }

  Future<void> fetchStates() async {
    try {
      isLoading(true);
      states.value = await StateService().getAllStates();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteState(String stateId) async {
    try {
      isLoading(true);
      await StateService().deleteState(stateId);
      states.removeWhere((state) => state.id == stateId);
      Get.snackbar('Success', 'State deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete state: $e');
    } finally {
      isLoading(false);
    }
  }
}

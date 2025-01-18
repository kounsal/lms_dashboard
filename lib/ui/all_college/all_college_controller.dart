import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/data/model/college/college_model.dart';
import 'package:lms_admin/data/model/state/state_model.dart';
import 'package:lms_admin/data/services/collegeService.dart';
import 'package:lms_admin/ui/all_state/all_state_controller.dart';

class CollegeController extends GetxController {
  var colleges = <CollegeModel>[].obs;
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
      colleges.value = await CollegeService().getAllColleges();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<void> addCollege(BuildContext context) async {
    final AllStateController allStateController = Get.find<AllStateController>();

    final nameController = TextEditingController();
    final regionController = TextEditingController();
    final thumbnailController = TextEditingController();
    var selectedState = Rx<StateModel?>(null);

    Get.defaultDialog(
      title: 'Add College',
      content: Obx(() {
        if (allStateController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (allStateController.errorMessage.isNotEmpty) {
          return Text('Error: ${allStateController.errorMessage}');
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'College Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: regionController,
                decoration: const InputDecoration(
                  labelText: 'Region',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: thumbnailController,
                decoration: const InputDecoration(
                  labelText: 'Thumbnail URL',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton<StateModel>(
                isExpanded: true,
                hint: const Text('Select State'),
                value: selectedState.value,  // Access the actual value inside Rx
                items: allStateController.states
                    .map((state) => DropdownMenuItem<StateModel>(
                  value: state,
                  child: Text(state.name ?? 'Unknown'),
                ))
                    .toList(),
                onChanged: (state) {
                  selectedState.value = state;  // Use .value to update the reactive variable
                  print("seeeeeeeeeeeeeeeee ${selectedState.value?.id} ${state?.id}");
                  update(); // Trigger UI rebuild.
                },
              )
            ],
          ),
        );
      }),
      textConfirm: 'Add',
      onConfirm: () async {
        if (nameController.text.isEmpty ||
            regionController.text.isEmpty ||
            thumbnailController.text.isEmpty ||
            selectedState == null) {
          Get.snackbar('Error', 'All fields are required');
          return;
        }

        try {
          Get.back();
          isLoading(true);
          // if (selectedState == null) {
          //   Get.snackbar('Error', 'Please select a state');
          //   return;
          // }
print("selectedState ${selectedState?.toJson()}");

          final newCollege = CollegeModel(
            name: nameController.text,
            region: regionController.text,
            stateId: selectedState.value?.id,
            thumbnail: thumbnailController.text,
          );
          final addedCollege = await CollegeService().addCollege(newCollege);

          colleges.add(addedCollege);
          Get.snackbar('Success', 'College added successfully');
        } catch (e) {
          print(e);
          Get.snackbar('Error', 'Failed to add college: $e');
        } finally {
          isLoading(false);
        }
      },
      textCancel: 'Cancel',
      onCancel: () => Get.back(),
    );
  }
}


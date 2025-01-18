import 'package:get/get.dart';
import 'package:lms_admin/data/model/category/category_model.dart';
import 'package:lms_admin/data/services/categoryService.dart';
import 'package:lms_admin/data/services/collegeService.dart';
import 'package:lms_admin/ui/all_category/all_category_controller.dart';

class AddCategoryController extends GetxController {
  final CategoryService _categoryService = CategoryService();
  final CategoryController _categoryController = Get.put(CategoryController());

  var name = ''.obs;
  var keyword = ''.obs;
  var description = ''.obs;
  var collegeIds = <String>[].obs;

  var isLoading = false.obs;

  bool validateInputs() {
    if (name.value.isEmpty) {
      Get.snackbar('Error', 'Category name is required');
      return false;
    }
    if (keyword.value.isEmpty) {
      Get.snackbar('Error', 'Keyword is required');
      return false;
    }
    if (description.value.isEmpty) {
      Get.snackbar('Error', 'Description is required');
      return false;
    }
    if (collegeIds.isEmpty) {
      Get.snackbar('Error', 'At least one college ID must be selected');
      return false;
    }
    return true;
  }

  void createCategory() async {
    if (!validateInputs()) return;

    try {
      isLoading.value = true;

      final category = CategoryModel(
        id: '',
        name: name.value,
        keyword: keyword.value,
        description: description.value,
        collegeIds: collegeIds.toList(),
      );

      await _categoryService.addCategory(category);

      Get.snackbar('Success', 'Category created successfully');
      _categoryController.fetchCategories();
      resetFields();
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to create category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void resetFields() {
    name.value = '';
    keyword.value = '';
    description.value = '';
    collegeIds.clear();
  }

  void toggleCollegeId(String collegeId) {
    if (collegeIds.contains(collegeId)) {
      collegeIds.remove(collegeId);
    } else {
      collegeIds.add(collegeId);
    }
  }

  @override
  void onClose() {
    super.onClose();
    resetFields();
  }
}

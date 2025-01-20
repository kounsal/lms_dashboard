import 'package:get/get.dart';
import 'package:lms_admin/data/model/category/category_model.dart';
import 'package:lms_admin/data/services/categoryService.dart';
import 'package:lms_admin/data/services/collegeService.dart';

class CategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final CategoryService _categoryService = CategoryService();
  final CollegeService _collegeService = CollegeService();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      errorMessage('');
      var fetchedCategories = await _categoryService.getAllCategories();

      for (CategoryModel category in fetchedCategories) {
        await category.fetchColleges(_collegeService);
      }
      categories.assignAll(fetchedCategories);
    } catch (error) {
      errorMessage('Error fetching categories');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      isLoading(true);
      await _categoryService.deleteCategory(id);
      categories.removeWhere((college) => college.id == id);
      Get.snackbar('Success', 'College deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete college: $e');
    } finally {
      isLoading(false);
    }
  }
}

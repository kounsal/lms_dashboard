import 'package:get/get.dart';
import 'package:lms_admin/data/services/courseService.dart';
import 'package:lms_admin/ui/all_course/all_course_controller.dart';

class CreateCourseController extends GetxController {
  final CourseService _courseService = CourseService();
  final CourseController _courseController = Get.find<CourseController>();

  var title = ''.obs;
  var description = ''.obs;
  var price = 0.0.obs;
  var isFree = false.obs;
  var priceWithDiscount = 0.0.obs;
  var discountPercent = 0.obs;
  var image = ''.obs;
  var thumbnail = ''.obs;
  var type = ''.obs;
  var link = ''.obs;
  var duration = 0.obs;
  var category = ''.obs;
  var teacher = ''.obs;
  var subscriptionIncluded = false.obs;
  var topics = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  void addTopic(String topicTitle) {
    topics.add({
      "title": topicTitle,
      "totalDuration": "0",
      "lessons": []
    });
  }

  void removeTopic(int index) {
    topics.removeAt(index);
  }

  void addLesson(int topicIndex, String lessonTitle, String lessonUrl, String lessonType , String duration) {
    topics[topicIndex]['lessons'].add({
      "title": lessonTitle,
      "lessonUrl": lessonUrl,
      "duration":  duration ,
      "isComplete": false,
      "type": lessonType
    });
    topics.refresh();
  }

  void removeLesson(int topicIndex, int lessonIndex) {
    topics[topicIndex]['lessons'].removeAt(lessonIndex);
    topics.refresh();
  }

  bool validateInputs() {
    if (title.value.isEmpty) {
      Get.snackbar('Error', 'Title is required');
      return false;
    }
    if (description.value.isEmpty) {
      Get.snackbar('Error', 'Description is required');
      return false;
    }
    if (!isFree.value && price.value <= 0) {
      Get.snackbar('Error', 'Price is required when the course is not free');
      return false;
    }
    if (image.value.isEmpty) {
      Get.snackbar('Error', 'Image URL is required');
      return false;
    }
    if (thumbnail.value.isEmpty) {
      Get.snackbar('Error', 'Thumbnail URL is required');
      return false;
    }
    if (type.value.isEmpty) {
      Get.snackbar('Error', 'Course Type is required');
      return false;
    }
    if (link.value.isEmpty) {
      Get.snackbar('Error', 'Link is required');
      return false;
    }
    if (duration.value <= 0) {
      Get.snackbar('Error', 'Duration must be a positive number');
      return false;
    }
    if (category.value.isEmpty) {
      Get.snackbar('Error', 'Category is required');
      return false;
    }
    if (teacher.value.isEmpty) {
      Get.snackbar('Error', 'Instructor is required');
      return false;
    }
    return true;
  }

void createCourse() async {
  if (!validateInputs()) return;

  try {
    isLoading.value = true;

    final courseData = {
      "title": title.value,
      "description": description.value,
      "price": isFree.value ? 0.0 : price.value,
      "isFree": isFree.value,
      "priceWithDiscount": priceWithDiscount.value,
      "discountPercent": discountPercent.value,
      "image": image.value,
      "thumbnail": thumbnail.value,
      "type": type.value,
      "link": link.value,
      "duration": duration.value,
      "category": category.value,
      "subscriptionIncluded": subscriptionIncluded.value,
      "badges": ["Best Seller", "Beginner Friendly"], // Example badges
      "topics": topics.map((topic) => {
        "title": topic["title"],
        "totalDuration": topic["totalDuration"], // Ensure correct format hh:mm:ss
        "lessons": topic["lessons"].map((lesson) => {
          "title": lesson["title"],
          "lessonUrl": lesson["lessonUrl"],
          "duration": lesson["duration"], 
          "isComplete": lesson["isComplete"],
          "type": lesson["type"],
        }).toList()
      }).toList()
    };

    print("Final Payload: ${courseData.toString()}");

    await _courseService.createCourse(courseData);
    Get.snackbar('Success', 'Course created successfully');
    _courseController.fetchCourses();
  } catch (e) {
    Get.snackbar('Error', 'Failed to create course: $e');
  } finally {
    isLoading.value = false;
  }
}

}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/data/model/category/category_model.dart';
import 'package:lms_admin/ui/all_category/all_category_controller.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController = Get.put(CategoryController());

    return Scaffold(
      backgroundColor: Colors.green.withOpacity(0.1),
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (categoryController.errorMessage.isNotEmpty) {
          return Center(child: Text(categoryController.errorMessage.value));
        } else if (categoryController.categories.isEmpty) {
          return Center(child: Text('No categories found.', style: TextStyle(fontSize: 18)));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    // color: Colors.green.shade700,
                  ),
                ),
              ),
              // Grid view for categories
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: categoryController.categories.length,
                  itemBuilder: (context, index) {
                    CategoryModel category = categoryController.categories[index];
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  category.name,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    // Handle delete action
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 8),

                            Row(
                              children: [
                                Icon(Icons.key, color: Colors.yellow.shade700),
                                SizedBox(width: 5),
                                Text(
                                  ' ${category.keyword}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.yellow.shade700,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),

                            // Description
                            Text(
                              'Description: ${category.description}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 12),

                            Text(
                              'Colleges:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),

                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: category.colleges.length,
                                itemBuilder: (context, collegeIndex) {
                                  var college = category.colleges[collegeIndex];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.school, size: 50, color: Colors.green.withOpacity(0.5)),
                                            SizedBox(height: 8),
                                            Text(
                                              college.name,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Region: ${college.region}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'State: ${college.state?.name}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

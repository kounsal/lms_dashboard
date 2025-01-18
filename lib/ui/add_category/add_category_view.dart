import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/ui/add_category/add_category_controller.dart';
import 'package:lms_admin/ui/all_college/all_college_controller.dart';

class AddCategoryView extends StatelessWidget {
  final AddCategoryController addCategoryController = Get.put(AddCategoryController());
  final CollegeController collegeController = Get.put(CollegeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.05),
      appBar: AppBar(
        title: const Text("Add Category"),
        centerTitle: true,
      ),
      body: Obx(
            () => collegeController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Details Section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Category Details',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Category Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade400),
                            ),
                          ),
                          onChanged: (value) => addCategoryController.name.value = value,
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Keyword',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade400),
                            ),
                          ),
                          onChanged: (value) => addCategoryController.keyword.value = value,
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade400),
                            ),
                          ),
                          maxLines: 3,
                          onChanged: (value) => addCategoryController.description.value = value,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Colleges',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Obx(() {
                          if (collegeController.errorMessage.isNotEmpty) {
                            return Text(
                              "Error: ${collegeController.errorMessage}",
                              style: const TextStyle(color: Colors.red),
                            );
                          }
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green.withOpacity(0.3)),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: null,
                              hint: const Text("Select College"),
                              items: collegeController.colleges.map((college) {
                                return DropdownMenuItem<String>(
                                  value: college.id,
                                  child: Text(college.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  addCategoryController.toggleCollegeId(value);
                                }
                              },
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              underline: SizedBox.shrink(),  // This removes the extra line under the dropdown
                            ),
                          );
                        }),

                        const SizedBox(height: 12),
                        Obx(() {
                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: addCategoryController.collegeIds.map((id) {
                              // Find the college by ID from the colleges list
                              final college = collegeController.colleges.firstWhere(
                                    (college) => college.id == id,
                                // orElse: () => null, // Handle case where college is not found
                              );

                              return Chip(
                                label: Text(college?.name ?? 'Unknown College'), // Display the name or fallback to 'Unknown College'
                                onDeleted: () => addCategoryController.toggleCollegeId(id),
                                backgroundColor: Colors.blue.shade100,
                              );
                            }).toList(),
                          );
                        }),

                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

              Center(
                child: Obx(() {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.withOpacity(0.3),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: addCategoryController.isLoading.value
                          ? null
                          : addCategoryController.createCategory,
                      child: addCategoryController.isLoading.value
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text(
                        "Create Category",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

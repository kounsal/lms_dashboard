import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/ui/add_instructor/add_instructor_controller.dart';

class AddInstructorView extends StatelessWidget {
  final AddInstructorController controller = Get.put(AddInstructorController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController biographyController = TextEditingController();
  // final TextEditingController avatarController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green.withOpacity(0.2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Add Instructor',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Row with two sections
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sign-Up Section
                  Expanded(
                    child: _buildCard(
                      title: 'Sign Up Details',
                      children: [
                        _buildTextField('Email', emailController),
                        _buildTextField('Password', passwordController, obscureText: true),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Instructor Info Section
                  Expanded(
                    child: _buildCard(
                      title: 'Instructor Info',
                      children: [
                        _buildTextField('Name', nameController),
                        _buildTextField('Biography', biographyController),
                        // _buildTextField('Avatar URL', avatarController),
                        _buildTextField('Phone', phoneController),
                        _buildTextField('State', stateController),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Register Button
            Align(
              alignment: Alignment.bottomRight,
              child: Obx(() {
                return controller.isLoading.value
                    ? const CircularProgressIndicator()
                : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    controller.addInstructor(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      biography: biographyController.text.trim(),
                      // avatar: avatarController.text.trim(),
                      phone: phoneController.text.trim(),
                      state: stateController.text.trim(),
                    );
                  },
                  child: const Text(
                    'Register Instructor',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Card Widget with Title
  Widget _buildCard({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 0.2, // Set the border thickness
              ),
            ),
            hintText: 'Enter $label',
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

}

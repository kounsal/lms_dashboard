import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/ui/sign-in/sign_in_controller.dart';

class GenerateAccessCode extends StatelessWidget {
 GenerateAccessCode({super.key});
//  final TextEditingController emailController = TextEditingController();
 final controller = Get.put(SignInController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
               buildCard(
                 title: 'Generate Acceess Code',
                 children: [
                   buildTextField('Email', controller.emailController),
                 
                 ],
               ),
               TextButton(onPressed: ()async{
                controller.generateCode();
          
               }, child: const Text("Generate Code")),
          
                    
               controller.isLoading.value ? Container(
                color: const Color.fromARGB(71, 0, 0, 0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(child: CircularProgressIndicator()),
               )   : const SizedBox.shrink()    
            ],
          ),
        ],
      ),
    );
  }


    Widget buildCard({required String title, required List<Widget> children}) {
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

  Widget buildTextField(String label, TextEditingController controller,
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
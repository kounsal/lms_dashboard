import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/ui/create_exam/create_exam_controller.dart';


class CreateExamVieew extends StatelessWidget {
  final CreateExamController controller = Get.put(CreateExamController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Exam')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Title', controller.title),
              _buildTextField('Description', controller.description),
              Obx(() => SwitchListTile(
                    title: Text('Is Free?'),
                    value: controller.isFree.value,
                    onChanged: (value) => controller.isFree.value = value,
                  )),
              _buildTextField('Price', controller.price, keyboardType: TextInputType.number),
              _buildTextField('Duration (minutes)', controller.duration, keyboardType: TextInputType.number),
              const SizedBox(height: 10),
             Row(
              children: [
                 ElevatedButton(
                onPressed: () => controller.pickFile(),
                child: Text('Upload Questions (Excel/CSV)'),
              ),
              const SizedBox(width: 50,),
               ElevatedButton(
                onPressed: () => {
                  controller.downloadTemplate()
                },
                child: Text('Download Template'),
              ),
              ],
             ),
              const SizedBox(height: 20),
              Obx(() => controller.questions.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Questions:', style: TextStyle(fontWeight: FontWeight.bold)),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.questions.length,
                          itemBuilder: (context, index) {
                            final question = controller.questions[index];
                            return ListTile(
                              title: Text(question['question']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...question['options'].map((opt) => Text('• $opt')).toList(),
                                  Text('Correct: ${question['correctAnswer']}',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  : Text('No questions added yet.')),
              const SizedBox(height: 20),
              Obx(() => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: controller.createExam,
                      child: Text('Create Exam'),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, RxString controller, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        keyboardType: keyboardType,
        onChanged: (value) => controller.value = value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
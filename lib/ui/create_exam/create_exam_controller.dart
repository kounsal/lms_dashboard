import 'dart:io';
import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:html' as html;
class CreateExamController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isFree = false.obs;
  RxString title = ''.obs;
  RxString description = ''.obs;
  RxString price = ''.obs;
  RxString duration = ''.obs;
  RxList<Map<String, dynamic>> questions = <Map<String, dynamic>>[].obs;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: false,
      allowMultiple: false,
      allowedExtensions: ['xlsx', 'csv'],
      type: FileType.custom,
    );

    if (result != null) {
      if (result.files.first.extension == "csv") {
        extractDataFromCSV(result.files.first.bytes!);
      } else {
        extractDataFromExcel(bytes: result.files.first.bytes!);
      }
    }
  }

  void extractDataFromExcel({required Uint8List bytes}) {
    try {
      Excel excel = Excel.decodeBytes(bytes);
      List<Map<String, dynamic>> parsedQuestions = [];

      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows.skip(1)) { // Skip header row
          if (row.every((cell) => cell == null)) continue;

          parsedQuestions.add({
            "question": row[0]?.value.toString() ?? '',
            "options": [
              row[1]?.value.toString() ?? '',
              row[2]?.value.toString() ?? '',
              row[3]?.value.toString() ?? '',
              row[4]?.value.toString() ?? '',
            ],
            "correctAnswer": row[5]?.value.toString() ?? '',
          });
        }
      }

      if (parsedQuestions.isNotEmpty) {
        questions.assignAll(parsedQuestions);
      } else {
        Get.snackbar("Error", "No questions found in the file.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to parse Excel file.");
    }
  }
void downloadTemplate() {
    try {
      html.AnchorElement anchorElement = html.AnchorElement(href: "https://lms.bharatchains.com/template/template.xlsx")
        ..setAttribute("download", "exam_template.xlsx")
        ..click(); // Triggers download

      Get.snackbar('Success', 'Template downloading...');
    } catch (e) {
      Get.snackbar('Error', 'Failed to download template');
    }
  }
  void extractDataFromCSV(Uint8List bytes) async {
    try {
      String csvString = utf8.decode(bytes);
      List<String> rows = csvString.split("\n");
      List<Map<String, dynamic>> parsedQuestions = [];

      for (int i = 1; i < rows.length; i++) { // Skip header row
        List<String> cols = rows[i].split(",");
        if (cols.length < 6) continue; // Ensure valid structure

        parsedQuestions.add({
          "question": cols[0].trim(),
          "options": [
            cols[1].trim(),
            cols[2].trim(),
            cols[3].trim(),
            cols[4].trim(),
          ],
          "correctAnswer": cols[5].trim(),
        });
      }

      if (parsedQuestions.isNotEmpty) {
        questions.assignAll(parsedQuestions);
      } else {
        Get.snackbar("Error", "No questions found in the CSV file.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to parse CSV file.");
    }
  }

  Future<void> createExam() async {
    if (title.value.isEmpty ||
        description.value.isEmpty ||
        price.value.isEmpty ||
        duration.value.isEmpty ||
        questions.isEmpty) {
      Get.snackbar("Error", "All fields are required.");
      return;
    }

    isLoading.value = true;

    Map<String, dynamic> examData = {
      "title": title.value,
      "isFree": isFree.value,
      "price": price.value,
      "duration": duration.value,
      "questions": questions,
    };
//temp implementation
    try {
      final response = await http.post(
        Uri.parse('https://lms-backend-gc2i.onrender.com/api/exam/create-exam'),
        body: jsonEncode(examData),
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2Nzg2MTcxYjFlMDRjODM3MTQ5NmFhMTQiLCJpYXQiOjE3Mzg2MTc5OTh9.34JJo3O3N460NMitG5xUVqXVZFoObqaeWULrFKK5iGw',
        },
      );
 print(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Exam created successfully!");
        questions.clear();
        title.value = "";
        description.value = "";
        price.value = "";
        duration.value = "";
      } else {
        Get.snackbar("Error", "Failed to create exam.");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Network error. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}

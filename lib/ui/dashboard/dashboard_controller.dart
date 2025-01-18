import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/ui/add_category/add_category_view.dart';
import 'package:lms_admin/ui/add_instructor/add_instructor_view.dart';
import 'package:lms_admin/ui/all_category/all_category_view.dart';
import 'package:lms_admin/ui/all_college/all_college_view.dart';
import 'package:lms_admin/ui/all_course/all_course_view.dart';
import 'package:lms_admin/ui/all_instructor/all_instructor_view.dart';
import 'package:lms_admin/ui/all_state/all_state_view.dart';
import 'package:lms_admin/ui/create-course/create_course_view.dart';
import 'package:lms_admin/ui/home/home_view.dart';
import 'package:lms_admin/ui/student/students_view.dart';
import 'package:lms_admin/ui/transaction/all_transaction_view.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  final pages = [
    HomeView(),
    StudentView(),
    CourseView(),
    InstructorView(),
    AllTransactionView(),
    AddInstructorView(),
    CreateCourseView(),
    CategoryPage(),
    CollegeListPage(),
    AllStateView(),
    AddCategoryView(),
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}

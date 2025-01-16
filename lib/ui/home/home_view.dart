import 'package:flutter/material.dart';
import 'package:lms_admin/ui/admin_revenue/admin_revenue_view.dart';
import 'package:lms_admin/ui/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:lms_admin/ui/transaction/last_transaction_view.dart';


class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    // homeController.onInit();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CountDisplayWidget(
                    count: homeController.totalUsersCount.value,
                    title: "Number Of Total Users",
                    color: Color(0xFFE0A88B),
                    opacity: 0.6,
                  ),
                  CountDisplayWidget(
                    count: homeController.totalCoursesCount.value,
                    title: "Number Of Total Courses",
                    color: Color(0xFFACD5E7),
                    opacity: 0.6,
                  ),
                  CountDisplayWidget(
                    count: homeController.totalInstructorCount.value,
                    title: "Number Of Total Instructors",
                    color: Color(0xFFE0CC8B),
                    opacity: 0.6,
                  ),
                  CountDisplayWidget(
                    count: homeController.totalStudentCount.value,
                    title: "Number Of Total Students",
                    color: Color(0xFFD3ACE7),
                    opacity: 0.6,
                  ),
                  CountDisplayWidget(
                    count: homeController.totalLessonsCount.value,
                    title: "Number Of Total Lessons",
                    color: Color(0xFF605A64),
                    opacity: 0.6,
                  ),
                ],
              );
            }),
            SizedBox(height: 20,),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                        child: Text(
                          'Revenue This Year',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      flex: 3,
                        child:  Text(
                          'Last 5 Transaction',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                        child: Center(child: AdminRevenueView())),
                    SizedBox(width: 20,),
                    Expanded(
                        flex: 3,
                        child: Center(child: TransactionHistoryView())),
                  ],
                ),

              ],
            ),
          ],
        )
      ),
    );
  }
}

class CountDisplayWidget extends StatelessWidget {
  final int count;
  final String title;
  final Color color;
  final double opacity;

  const CountDisplayWidget({
    Key? key,
    required this.count,
    required this.title,
    required this.color,
    this.opacity = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = color.withOpacity(opacity);

    return Container(
      height: 185,
      width: 220,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
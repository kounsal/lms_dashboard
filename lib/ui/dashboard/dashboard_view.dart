import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/ui/dashboard/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());

    return Scaffold(
      body: Row(
        children: [
          // Sidebar for navigation
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            width: 240,
            color: Colors.white,
            child: Column(
              children: [
                Obx(() => buildNavigationItem(
                  icon: Icons.home,
                  label: 'Home',
                  isSelected: controller.selectedIndex.value == 0,
                  onTap: () => controller.onItemTapped(0),
                )),
                Obx(() => buildNavigationItem(
                  icon: Icons.supervised_user_circle_outlined,
                  label: 'Students',
                  isSelected: controller.selectedIndex.value == 1,
                  onTap: () => controller.onItemTapped(1),
                )),
                Obx(() => buildNavigationItem(
                  icon: Icons.dashboard,
                  label: 'Courses',
                  isSelected: controller.selectedIndex.value == 2,
                  onTap: () => controller.onItemTapped(2),
                )),
                Obx(() => buildNavigationItem(
                  icon: Icons.pageview_outlined,
                  label: 'Instructors',
                  isSelected: controller.selectedIndex.value == 3,
                  onTap: () => controller.onItemTapped(3),
                )),
                Obx(() => buildNavigationItem(
                  icon: Icons.local_offer_outlined,
                  label: 'Transaction',
                  isSelected: controller.selectedIndex.value == 4,
                  onTap: () => controller.onItemTapped(4),
                )),
                Obx(() => buildNavigationItem(
                  icon: Icons.add_business_outlined,
                  label: 'Add Instructor',
                  isSelected: controller.selectedIndex.value == 5,
                  onTap: () => controller.onItemTapped(5),
                )),
                Obx(() => buildNavigationItem(
                  icon: Icons.add_chart_sharp,
                  label: 'Add Course',
                  isSelected: controller.selectedIndex.value == 6,
                  onTap: () => controller.onItemTapped(6),
                )),
                Obx(() => buildNavigationItem(
                  icon: Icons.category,
                  label: 'All Category',
                  isSelected: controller.selectedIndex.value == 7,
                  onTap: () => controller.onItemTapped(7),
                )),
                Obx(() => buildNavigationItem(
                  icon: Icons.cast_for_education,
                  label: 'All College',
                  isSelected: controller.selectedIndex.value == 8,
                  onTap: () => controller.onItemTapped(8),
                )),
                Obx(() => buildNavigationItem(
                  icon: Icons.flag,
                  label: 'All States',
                  isSelected: controller.selectedIndex.value == 9,
                  onTap: () => controller.onItemTapped(9),
                )),
                Obx(() => buildNavigationItem(
                  icon: Icons.add_chart,
                  label: 'Add category',
                  isSelected: controller.selectedIndex.value == 10,
                  onTap: () => controller.onItemTapped(10),
                )),
                 Obx(() => buildNavigationItem(
                  icon: Icons.add_chart,
                  label: 'Create Exam',
                  isSelected: controller.selectedIndex.value == 11,
                  onTap: () => controller.onItemTapped(11),
                )),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Main content area
          Expanded(
            child: Obx(() => IndexedStack(
              index: controller.selectedIndex.value,
              children: controller.pages,
            )),
          ),
        ],
      ),
    );
  }


  Widget buildNavigationItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          color: isSelected ? Colors.green.withOpacity(0.1) : Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? Colors.green : Colors.grey),
              const SizedBox(width: 8.0),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.green : Colors.grey,
                  fontWeight: isSelected ? FontWeight.normal : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

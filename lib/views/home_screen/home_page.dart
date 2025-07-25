/// lib/auth/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../controller/student_controller.dart';
import '../../debug_screen.dart';
import '../student_screens/add.dart';
import '../student_screens/delete.dart';
import '../student_screens/update.dart';
import '../student_screens/view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(StudentController());
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text('Student Manager'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: IconButton(
              icon: Icon(Icons.logout_rounded),
              onPressed: () {
                Get.defaultDialog(
                  title: 'Logout',
                  titleStyle: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                  middleText: 'Are you sure you want to logout?',
                  middleTextStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFF666666),
                  ),
                  confirm: ElevatedButton(
                    onPressed: () {
                      AuthController.instance.signOut();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(80.w, 40.h),
                    ),
                    child: Text('Logout'),
                  ),
                  cancel: TextButton(
                    onPressed: () => Get.back(),
                    child: Text('Cancel'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1976D2), Color(0xFF1565C0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF1976D2).withOpacity(0.3),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.dashboard_rounded,
                    color: Colors.white,
                    size: 32.sp,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Manage your students efficiently',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Actions Grid
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),

            SizedBox(height: 16.h),

            // Grid of Action Cards
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 1.1,
              children: [
                _buildActionCard(
                  icon: Icons.person_add_rounded,
                  title: 'Add Student',
                  subtitle: 'Register new student',
                  color: Color(0xFF4CAF50),
                  onTap: () => Get.to(() => AddStudentScreen()),
                ),
                _buildActionCard(
                  icon: Icons.people_rounded,
                  title: 'View Students',
                  subtitle: 'Browse all students',
                  color: Color(0xFF2196F3),
                  onTap: () => Get.to(() => ViewStudentsScreen()),
                ),
                _buildActionCard(
                  icon: Icons.edit_rounded,
                  title: 'Update Student',
                  subtitle: 'Modify student info',
                  color: Color(0xFFFF9800),
                  onTap: () => Get.to(() => UpdateStudentScreen()),
                ),
                _buildActionCard(
                  icon: Icons.person_remove_rounded,
                  title: 'Delete Student',
                  subtitle: 'Remove student',
                  color: Color(0xFFF44336),
                  onTap: () => Get.to(() => DeleteStudentScreen()),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Debug Section (Optional)
            Card(
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.bug_report_rounded,
                    color: Colors.orange,
                    size: 24.sp,
                  ),
                ),
                title: Text(
                  'Debug Firestore',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Troubleshoot database issues',
                  style: TextStyle(fontSize: 12.sp),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                onTap: () => Get.to(() => DebugScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: color, size: 24.sp),
              ),

              SizedBox(height: 12.h),

              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),

              SizedBox(height: 4.h),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.sp, color: Color(0xFF666666)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

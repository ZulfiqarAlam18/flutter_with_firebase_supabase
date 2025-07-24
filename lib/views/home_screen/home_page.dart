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
      appBar: AppBar(
        title: Text('Student Manager', style: TextStyle(fontSize: 20.sp)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Get.defaultDialog(
                title: 'Logout',
                middleText: 'Are you sure you want to logout?',
                onConfirm: () {
                  AuthController.instance.signOut();
                  Get.back();
                },
                onCancel: () => Get.back(),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Get.to(() => AddStudentScreen()),
              child: Text('Add Student', style: TextStyle(fontSize: 18.sp)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.h),
              ),
            ),
            SizedBox(height: 15.h),
            ElevatedButton(
              onPressed: () => Get.to(() => ViewStudentsScreen()),
              child: Text('View Students', style: TextStyle(fontSize: 18.sp)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.h),
              ),
            ),
            SizedBox(height: 15.h),
            ElevatedButton(
              onPressed: () => Get.to(() => UpdateStudentScreen()),
              child: Text('Update Student', style: TextStyle(fontSize: 18.sp)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.h),
              ),
            ),
            SizedBox(height: 15.h),
            ElevatedButton(
              onPressed: () => Get.to(() => DeleteStudentScreen()),
              child: Text('Delete Student', style: TextStyle(fontSize: 18.sp)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.h),
              ),
            ),
            SizedBox(height: 15.h),
            ElevatedButton(
              onPressed: () => Get.to(() => DebugScreen()),
              child: Text(
                '🔍 Debug Firestore',
                style: TextStyle(fontSize: 18.sp),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.h),
                backgroundColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

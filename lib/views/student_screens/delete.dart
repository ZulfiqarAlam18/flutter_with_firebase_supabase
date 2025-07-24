/// lib/auth/delete_student_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/student_controller.dart';
import '../../models/student_model.dart';

class DeleteStudentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    final controller = Get.put(StudentController());

    return Scaffold(
      appBar: AppBar(title: Text('Delete Student')),
      body: StreamBuilder<List<Student>>(
        stream: controller.students,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snap.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text('Error: ${snap.error}'),
                ],
              ),
            );
          }

          if (!snap.hasData || snap.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No students found'),
                ],
              ),
            );
          }

          final list = snap.data!;
          return ListView.builder(
            padding: EdgeInsets.all(20.w),
            itemCount: list.length,
            itemBuilder: (c, i) {
              final s = list[i];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    s.imageUrl,
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 50.w,
                        height: 50.h,
                        color: Colors.grey[300],
                        child: Icon(Icons.person, color: Colors.grey[600]),
                      );
                    },
                  ),
                ),
                title: Text(s.name),
                subtitle: Text('Roll: ${s.roll}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDelete(context, s.id),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    Get.defaultDialog(
      title: 'Confirm',
      middleText: 'Delete this student?',
      onConfirm: () async {
        try {
          Get.back(); // Close dialog first
          await StudentController.instance.deleteStudent(id);
          Get.snackbar(
            "Success",
            "Student deleted successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } catch (e) {
          Get.snackbar(
            "Error",
            "Failed to delete student: $e",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
      },
      onCancel: () => Get.back(),
    );
  }
}

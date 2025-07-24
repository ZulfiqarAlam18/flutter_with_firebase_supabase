/// lib/auth/view_students_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/student_controller.dart';
import '../../models/student_model.dart';

class ViewStudentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    final controller = Get.put(StudentController());

    return Scaffold(
      appBar: AppBar(title: Text('View Students')),
      body: StreamBuilder<List<Student>>(
        stream: controller.students,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No students found'),
                  Text('Add some students to see them here'),
                ],
              ),
            );
          }

          final list = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.all(20.w),
            itemCount: list.length,
            itemBuilder: (c, i) {
              final s = list[i];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                child: ListTile(
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
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 50.w,
                          height: 50.h,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                  title: Text(s.name),
                  subtitle: Text('Roll: ${s.roll}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

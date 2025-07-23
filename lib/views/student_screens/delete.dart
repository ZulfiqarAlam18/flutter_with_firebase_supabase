/// lib/auth/delete_student_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/student_controller.dart';
import '../../models/student_model.dart';

class DeleteStudentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Delete Student')),
      body: StreamBuilder<List<Student>>(
        stream: StudentController.instance.students,
        builder: (context, snap) {
          if (!snap.hasData) return Center(child: CircularProgressIndicator());
          final list = snap.data!;
          return ListView.builder(
            padding: EdgeInsets.all(20.w),
            itemCount: list.length,
            itemBuilder: (c, i) {
              final s = list[i];
              return ListTile(
                leading: Image.network(s.imageUrl, width: 50.w, height: 50.h, fit: BoxFit.cover),
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
      onConfirm: () {
        StudentController.instance.deleteStudent(id);
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }
}

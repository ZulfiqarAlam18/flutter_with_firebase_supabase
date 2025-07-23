/// lib/auth/update_student_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/student_controller.dart';
import '../../models/student_model.dart';

class UpdateStudentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Student')),
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
                  icon: Icon(Icons.edit),
                  onPressed: () => Get.to(() => _EditDialog(student: s)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _EditDialog extends StatefulWidget {
  final Student student;
  _EditDialog({required this.student});

  @override
  __EditDialogState createState() => __EditDialogState();
}

class __EditDialogState extends State<_EditDialog> {
  late TextEditingController nameCtrl;
  late TextEditingController rollCtrl;
  File? _image;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.student.name);
    rollCtrl = TextEditingController(text: widget.student.roll);
  }

  Future<void> pickImage() async {
    final p = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (p != null) setState(() => _image = File(p.path));
  }

  void save() async {
    if (nameCtrl.text.trim().isEmpty || rollCtrl.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      await StudentController.instance.updateStudent(
        widget.student.id,
        nameCtrl.text.trim(),
        rollCtrl.text.trim(),
        _image,
      );
      Get.snackbar(
        "Success",
        "Student updated successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update student: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: rollCtrl,
              decoration: InputDecoration(labelText: 'Roll'),
            ),
            SizedBox(height: 10.h),
            _image == null
                ? TextButton(onPressed: pickImage, child: Text('Change Image'))
                : Image.file(_image!, height: 100.h),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
        ElevatedButton(onPressed: save, child: Text('Save')),
      ],
    );
  }
}

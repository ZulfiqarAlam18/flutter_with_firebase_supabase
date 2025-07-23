/// lib/auth/add_student_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/student_controller.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final nameCtrl = TextEditingController();
  final rollCtrl = TextEditingController();
  File? _image;
  bool _loading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  void _save() async {
    if (_image == null) {
      Get.snackbar(
        "Error",
        "Please select an image",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    if (nameCtrl.text.trim().isEmpty || rollCtrl.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => _loading = true);
    try {
      await StudentController.instance.addStudent(
        nameCtrl.text.trim(),
        rollCtrl.text.trim(),
        _image!,
      );
      Get.snackbar(
        "Success",
        "Student added successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to add student: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Student')),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: rollCtrl,
              decoration: InputDecoration(labelText: 'Roll'),
            ),
            SizedBox(height: 10.h),
            _image == null
                ? TextButton.icon(
                  icon: Icon(Icons.image),
                  label: Text('Pick Image'),
                  onPressed: _pickImage,
                )
                : Image.file(_image!, height: 150.h),
            SizedBox(height: 20.h),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _save,
                  child: Text('Save', style: TextStyle(fontSize: 16.sp)),
                ),
          ],
        ),
      ),
    );
  }
}

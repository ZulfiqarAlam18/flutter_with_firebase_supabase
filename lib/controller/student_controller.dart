import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/student_model.dart';
import '../services/storage_service.dart';
import '../services/simple_notification_service.dart';

class StudentController extends GetxController {
  static StudentController instance = Get.find();

  final _db = FirebaseFirestore.instance;

  Stream<List<Student>> get students {
    return _db.collection('students').snapshots().map((snap) {
      final students =
          snap.docs.map((doc) {
            try {
              return Student.fromDoc(doc);
            } catch (e) {
              print('❌ Error parsing student document ${doc.id}: $e');
              print('📄 Document data: ${doc.data()}');
              rethrow;
            }
          }).toList();
      print('✅ Successfully parsed ${students.length} students');
      return students;
    });
  }

  /// Upload image to Supabase Storage and get public URL
  Future<String> _uploadImage(File file, String id) async {
    return await StorageService.uploadImage(file, '$id.jpg');
  }

  Future<void> addStudent(String name, String roll, File image) async {
    try {
      final id = Uuid().v4();
      final url = await _uploadImage(image, id);

      final studentData = {
        'id': id,
        'name': name,
        'roll': roll, // Make sure this matches your Firestore field
        'imageUrl': url,
      };

      await _db.collection('students').doc(id).set(studentData);

      // Send notification after student is added successfully
      await SimpleNotificationService.showStudentAddedNotification(
        studentName: name,
        rollNumber: roll,
      );

      print('✅ Student added successfully: $name');
    } catch (e) {
      print('❌ Error adding student: $e');
      rethrow; // Re-throw so UI can handle the error
    }
  }

  Future<void> deleteStudent(String id) async {
    // Delete from Firestore first
    await _db.collection('students').doc(id).delete();

    // Then delete from Supabase storage
    await StorageService.deleteImage('$id.jpg');
  }

  Future<void> updateStudent(
    String id,
    String name,
    String roll,
    File? image,
  ) async {
    String? url;
    if (image != null) {
      url = await _uploadImage(image, id);
    }
    final data = {'name': name, 'roll': roll, if (url != null) 'imageUrl': url};
    await _db.collection('students').doc(id).update(data);
  }
}

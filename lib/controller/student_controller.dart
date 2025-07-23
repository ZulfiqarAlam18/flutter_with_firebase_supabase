import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../models/student_model.dart';

class StudentController extends GetxController {
  static StudentController instance = Get.find();

  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Stream<List<Student>> get students => _db
      .collection('students')
      .snapshots()
      .map((snap) => snap.docs.map(Student.fromDoc).toList());

  Future<String> _uploadImage(File file, String id) async {
    final ref = _storage.ref().child('students/$id.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> addStudent(String name, String roll, File image) async {
    final id = Uuid().v4();
    final url = await _uploadImage(image, id);
    await _db.collection('students').doc(id).set({
      'id': id,
      'name': name,
      'roll': roll,
      'imageUrl': url,
    });
  }

  Future<void> deleteStudent(String id) async {
    await _db.collection('students').doc(id).delete();
    await _storage.ref().child('students/$id.jpg').delete();
  }

  Future<void> updateStudent(
      String id, String name, String roll, File? image) async {
    String? url;
    if (image != null) {
      url = await _uploadImage(image, id);
    }
    final data = {
      'name': name,
      'roll': roll,
      if (url != null) 'imageUrl': url,
    };
    await _db.collection('students').doc(id).update(data);
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DebugScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Debug Firestore')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: testFirestoreConnection,
              child: Text('Test Firestore Connection'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: listAllStudents,
              child: Text('List All Students'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addTestStudent,
              child: Text('Add Test Student'),
            ),
          ],
        ),
      ),
    );
  }

  void testFirestoreConnection() async {
    try {
      print('🔗 Testing Firestore connection...');
      final snapshot = await FirebaseFirestore.instance.collection('students').get();
      print('✅ Firestore connected! Found ${snapshot.docs.length} documents');
      
      Get.snackbar(
        "Success",
        "Firestore connected! Found ${snapshot.docs.length} documents",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('❌ Firestore connection failed: $e');
      Get.snackbar(
        "Error",
        "Firestore connection failed: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void listAllStudents() async {
    try {
      print('📋 Listing all students...');
      final snapshot = await FirebaseFirestore.instance.collection('students').get();
      
      for (var doc in snapshot.docs) {
        print('📄 Document ID: ${doc.id}');
        print('📄 Document data: ${doc.data()}');
      }
      
      Get.snackbar(
        "Info",
        "Check console for student list (${snapshot.docs.length} found)",
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } catch (e) {
      print('❌ Failed to list students: $e');
      Get.snackbar(
        "Error",
        "Failed to list students: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void addTestStudent() async {
    try {
      print('➕ Adding test student...');
      await FirebaseFirestore.instance.collection('students').add({
        'id': 'test123',
        'name': 'Test Student',
        'roll': '001',
        'imageUrl': '',
      });
      
      print('✅ Test student added successfully');
      Get.snackbar(
        "Success",
        "Test student added successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('❌ Failed to add test student: $e');
      Get.snackbar(
        "Error",
        "Failed to add test student: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

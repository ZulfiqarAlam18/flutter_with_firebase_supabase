/// lib/models/student_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String id;
  final String name;
  final String roll;
  final String imageUrl;

  Student({
    required this.id,
    required this.name,
    required this.roll,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'roll': roll,
    'imageUrl': imageUrl,
  };

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: (json['id'] as String?) ?? '', // Handle missing id
    name: json['name'] as String? ?? '', // Handle missing name
    roll: (json['roll'] as String?) ?? (json['rollNumber'] as String?) ?? '', // Handle both field names
    imageUrl: json['imageUrl'] as String? ?? '', // Handle null imageUrl
  );

  factory Student.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    
    // Use document ID if id field is missing or empty
    if (data['id'] == null || data['id'].toString().isEmpty) {
      data['id'] = doc.id;
    }
    
    return Student.fromJson(data);
  }
}

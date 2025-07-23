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
    id: json['id'] as String,
    name: json['name'] as String,
    roll: json['roll'] as String,
    imageUrl: json['imageUrl'] as String,
  );

  factory Student.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return Student.fromJson(data);
  }
}

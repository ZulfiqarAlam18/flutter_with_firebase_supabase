import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  static final SupabaseClient _supabase = Supabase.instance.client;
  static const String bucketName = 'student-pics';

  /// Upload image to Supabase Storage and return public URL
  static Future<String> uploadImage(File file, String fileName) async {
    final String path = 'students/$fileName';

    try {
      await _supabase.storage.from(bucketName).upload(path, file);

      final String publicUrl = _supabase.storage
          .from(bucketName)
          .getPublicUrl(path);

      return publicUrl;
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }

  /// Delete image from Supabase Storage
  static Future<void> deleteImage(String fileName) async {
    final String path = 'students/$fileName';

    try {
      await _supabase.storage.from(bucketName).remove([path]);
    } catch (e) {
      // Log the error but don't throw as it's not critical
      if (kDebugMode) {
        print('Warning: Failed to delete image from storage: $e');
      }
    }
  }

  /// Update image in Supabase Storage (deletes old and uploads new)
  static Future<String> updateImage(File newFile, String fileName) async {
    // Delete old image first (if exists)
    await deleteImage(fileName);

    // Upload new image
    return await uploadImage(newFile, fileName);
  }
}

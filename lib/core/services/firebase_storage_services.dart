import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(XFile imageFile) async {
    try {
      final fileId = const Uuid().v4();
      final ref = _storage.ref().child('images/$fileId.jpg');

      await ref.putFile(File(imageFile.path));
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint('❌ فشل رفع الصورة: $e');
      return null;
    }
  }

  Future<String?> updateImage(String oldImageUrl, XFile newFile) async {
    try {
      if (oldImageUrl.isNotEmpty) {
        await deleteImageByUrl(oldImageUrl);
      }
      return await uploadImage(newFile);
    } catch (e) {
      debugPrint('❌ فشل تحديث الصورة: $e');
      return null;
    }
  }

  Future<void> deleteImageByUrl(String imageUrl) async {
    try {
      final ref = _storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      debugPrint('❌ فشل حذف الصورة: $e');
    }
  }
}

/// كلاس مخصص للأخطاء
class StorageException implements Exception {
  final String message;
  final String code;

  StorageException({required this.message, required this.code});

  @override
  String toString() => 'StorageException($code): $message';
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// ImagePickerService
/// مسؤول فقط عن اختيار الصور (single / multiple) من الكاميرا أو المعرض.
/// **لا** يقوم بالضغط أو التعديل — هذا يجعل لكل كلاس مسؤولية واحدة (SRP).
class ImagePickerService {
  final ImagePicker _picker;

  ImagePickerService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  Future<XFile?> pickImage({bool fromCamera = false}) async {
    try {
      return await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 100,
      );
    } catch (e) {
      debugPrint('❌ فشل اختيار الصورة: $e');
      return null;
    }
  }

  Future<List<XFile>?> pickMultiImage() async {
    try {
      return await _picker.pickMultiImage(imageQuality: 100);
    } catch (e) {
      debugPrint('❌ فشل اختيار الصور: $e');
      return null;
    }
  }
}

class ImagePickerException implements Exception {
  final String message;
  ImagePickerException(this.message);
  @override
  String toString() => 'ImagePickerException: $message';
}

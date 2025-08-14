import 'package:image_picker/image_picker.dart';

/// ImagePickerService
/// مسؤول فقط عن اختيار الصور (single / multiple) من الكاميرا أو المعرض.
/// **لا** يقوم بالضغط أو التعديل — هذا يجعل لكل كلاس مسؤولية واحدة (SRP).
class ImagePickerService {
  final ImagePicker _picker;

  ImagePickerService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  ///XFile أو null. يختار صورة واحدة من الكاميرا أو المعرض ويعيد
  Future<XFile?> pickImage({bool fromCamera = false}) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 100, // لا نضغط هنا: مجرد نقل الصورة المختارة
      );
      return file;
    } catch (e) {
      throw ImagePickerException('فشل اختيار الصورة: $e');
    }
  }

  /// يختار عدة صور من المعرض (إن كانت مطلوبة)
  Future<List<XFile>?> pickMultiImage() async {
    try {
      final files = await _picker.pickMultiImage(imageQuality: 100);
      return files;
    } catch (e) {
      throw ImagePickerException('فشل اختيار الصور: $e');
    }
  }
}

class ImagePickerException implements Exception {
  final String message;
  ImagePickerException(this.message);
  @override
  String toString() => 'ImagePickerException: $message';
}

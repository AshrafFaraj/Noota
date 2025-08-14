import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// رفع صورة جديدة داخل مجلد images/
  /// تعيد رابط التحميل النهائي
  Future<String> uploadImage(XFile imageFile) async {
    var imagePath = imageFile.path;
    var file = File(imagePath);
    // var imageName = basename(imagePath);

    final fileId = const Uuid().v4(); // اسم فريد للصورة
    final ref = _storage.ref().child('images/$fileId.jpg');

    // رفع الملف
    await ref.putFile(file);

    // جلب رابط التحميل
    final downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  /// تعديل صورة (حذف القديمة ثم رفع جديدة)
  Future<String> updateImage(String oldImageUrl, XFile newFile) async {
    // حذف القديمة إذا موجودة
    if (oldImageUrl.isNotEmpty) {
      await deleteImageByUrl(oldImageUrl);
    }
    // رفع الجديدة
    final newDownloadUrl = await uploadImage(newFile);
    return newDownloadUrl;
  }

  /// حذف صورة عبر رابطها
  Future<void> deleteImageByUrl(String imageUrl) async {
    final ref = _storage.refFromURL(imageUrl);
    await ref.delete();
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

// image_compression_service.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImageCompressionService {
  Future<XFile?> compressXFile({
    required XFile originalXFile,
    int quality = 70,
    int maxWidth = 1024,
    int maxHeight = 1024,
    bool keepExif = false,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final targetPath = p.join(
        tempDir.path,
        'compressed_${DateTime.now().millisecondsSinceEpoch}${p.extension(originalXFile.path)}',
      );

      final result = await FlutterImageCompress.compressAndGetFile(
        originalXFile.path,
        targetPath,
        quality: quality,
        minWidth: maxWidth,
        minHeight: maxHeight,
        keepExif: keepExif,
      );

      if (result == null) {
        debugPrint('❌ لم يتم ضغط الصورة');
        return null;
      }

      return XFile(result.path);
    } catch (e) {
      debugPrint('❌ فشل ضغط الصورة: $e');
      return null;
    }
  }

  static double getFileSizeInMB(XFile file) {
    return File(file.path).lengthSync() / (1024 * 1024);
  }

  static double getFileSizeInKB(XFile file) {
    return File(file.path).lengthSync() / 1024;
  }

  static int determineCompressionQuality(XFile file) {
    final sizeMB = getFileSizeInMB(file);
    if (sizeMB > 5) return 50;
    if (sizeMB > 2) return 65;
    if (sizeMB > 1) return 75;
    return 85;
  }
}

class ImageCompressionException implements Exception {
  final String message;
  ImageCompressionException(this.message);
  @override
  String toString() => 'ImageCompressionException: $message';
}

import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// ImageCompressionService
/// مسؤول فقط عن ضغط الصور. يستقبل File (أو XFile عبر wrapper) ويعيد File مضغوط.
class ImageCompressionService {
  /// ضغط ملف وإرجاع ملف جديد داخل المجلد المؤقت
  Future<XFile?> compressFile(
    File file, {
    int quality = 70,
    int minWidth = 800,
    int minHeight = 800,
    String targetPrefix = 'compressed_',
  }) async {
    try {
      final dir = await getTemporaryDirectory();
      final targetPath = path.join(
        dir.path,
        '\$targetPrefix\${DateTime.now().millisecondsSinceEpoch}\${path.extension(file.path)}',
      );

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: quality,
        minWidth: minWidth,
        minHeight: minHeight,
        keepExif: false,
      );

      return result;
    } catch (e) {
      throw ImageCompressionException('فشل ضغط الصورة: $e');
    }
  }

  /// مساعدة لتمرير XFile مباشرة (تحولها إلى File ثم تضغط)
  Future<XFile?> compressXFile(
    XFile xfile, {
    int quality = 70,
    int minWidth = 800,
    int minHeight = 800,
    String targetPrefix = 'compressed_',
  }) async {
    final file = File(xfile.path);
    return await compressFile(
      file,
      quality: quality,
      minWidth: minWidth,
      minHeight: minHeight,
      targetPrefix: targetPrefix,
    );
  }
}

class ImageCompressionException implements Exception {
  final String message;
  ImageCompressionException(this.message);
  @override
  String toString() => 'ImageCompressionException: $message';
}

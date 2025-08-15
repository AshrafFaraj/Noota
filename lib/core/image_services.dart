// image_services.dart
import 'package:flutter/foundation.dart';

class ImageUploadResult {
  final String downloadUrl;
  final String fileId;
  final int fileSize; // حجم الملف بالبايت

  ImageUploadResult({
    required this.downloadUrl,
    required this.fileId,
    required this.fileSize,
  });
}

class ImageServiceException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  ImageServiceException(this.message, [this.stackTrace]);

  @override
  String toString() => 'ImageServiceException: $message';
}

typedef UploadProgressCallback = void Function(double progress);

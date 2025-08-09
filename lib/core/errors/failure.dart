import 'package:firebase_core/firebase_core.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class FirebaseFailure extends Failure {
  FirebaseFailure(super.errMessage);

  factory FirebaseFailure.fromFirebaseException(FirebaseException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return FirebaseFailure('البريد الإلكتروني غير صالح.');
      case 'user-disabled':
        return FirebaseFailure('تم تعطيل هذا المستخدم.');
      case 'user-not-found':
        return FirebaseFailure('لا يوجد مستخدم بهذا البريد.');
      case 'wrong-password':
        return FirebaseFailure('كلمة المرور غير صحيحة.');
      case 'email-already-in-use':
        return FirebaseFailure('البريد الإلكتروني مستخدم مسبقًا.');
      case 'operation-not-allowed':
        return FirebaseFailure('تم تعطيل تسجيل الدخول باستخدام هذا المزود.');
      case 'weak-password':
        return FirebaseFailure('كلمة المرور ضعيفة جدًا.');
      case 'network-request-failed':
        return FirebaseFailure('فشل الاتصال بالإنترنت.');
      case 'permission-denied':
        return FirebaseFailure('ليس لديك صلاحية للوصول إلى البيانات.');
      case 'unavailable':
        return FirebaseFailure('الخدمة غير متوفرة حاليًا. حاول لاحقًا.');
      default:
        return FirebaseFailure('حدث خطأ غير متوقع: ${exception.message}');
    }
  }

  factory FirebaseFailure.fromAnyError(Object error) {
    if (error is FirebaseException) {
      return FirebaseFailure.fromFirebaseException(error);
    } else {
      return FirebaseFailure('حدث خطأ غير متوقع: $error');
    }
  }
}

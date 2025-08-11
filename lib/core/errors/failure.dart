import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

class FirebaseFailure extends Failure {
  FirebaseFailure(super.errMessage);

  /// لمعالجة أخطاء FirebaseAuth
  factory FirebaseFailure.fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return FirebaseFailure('البريد الإلكتروني غير صالح.');
      case 'user-disabled':
        return FirebaseFailure('تم تعطيل هذا الحساب.');
      case 'user-not-found':
        return FirebaseFailure('لا يوجد مستخدم بهذا البريد الإلكتروني.');
      case 'wrong-password':
        return FirebaseFailure('كلمة المرور غير صحيحة.');
      case 'invalid-credential':
        return FirebaseFailure('البريد الالكتروني او كلمة المرور غير صحيحة.');
      case 'email-already-in-use':
        return FirebaseFailure('البريد الإلكتروني مستخدم مسبقًا.');
      case 'operation-not-allowed':
        return FirebaseFailure('تم تعطيل تسجيل الدخول بهذه الطريقة.');
      case 'weak-password':
        return FirebaseFailure(
            'كلمة المرور ضعيفة جدًا، الرجاء اختيار كلمة أقوى.');
      case 'too-many-requests':
        return FirebaseFailure(
            'عدد محاولات تسجيل الدخول كبير جدًا، حاول لاحقًا.');
      case 'network-request-failed':
        return FirebaseFailure('فشل الاتصال بالإنترنت.');
      default:
        return FirebaseFailure('حدث خطأ غير متوقع: ${e.message}');
    }
  }

  /// لمعالجة أخطاء Firestore
  factory FirebaseFailure.fromFirestoreException(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return FirebaseFailure('ليس لديك صلاحية للوصول إلى هذه البيانات.');
      case 'unavailable':
        return FirebaseFailure('الخدمة غير متوفرة حاليًا، حاول لاحقًا.');
      case 'not-found':
        return FirebaseFailure('المستند المطلوب غير موجود.');
      case 'already-exists':
        return FirebaseFailure('المستند موجود مسبقًا.');
      case 'cancelled':
        return FirebaseFailure('تم إلغاء العملية.');
      case 'invalid-argument':
        return FirebaseFailure('تم تمرير بيانات غير صالحة إلى الطلب.');
      case 'deadline-exceeded':
        return FirebaseFailure('انتهت مهلة العملية، حاول مرة أخرى.');
      case 'resource-exhausted':
        return FirebaseFailure('تم استهلاك الموارد المسموح بها، حاول لاحقًا.');
      case 'failed-precondition':
        return FirebaseFailure('العملية غير متاحة في الوقت الحالي.');
      case 'aborted':
        return FirebaseFailure('تم إيقاف العملية بسبب تعارض.');
      default:
        return FirebaseFailure(
            'حدث خطأ غير متوقع في قاعدة البيانات: ${e.message}');
    }
  }

  /// لمعالجة أي خطأ آخر من Firebase بشكل عام
  factory FirebaseFailure.fromFirebaseException(FirebaseException e) {
    return FirebaseFailure('حدث خطأ: ${e.message ?? e.code}');
  }

  /// لمعالجة أي نوع خطأ عام
  factory FirebaseFailure.fromAnyError(Object error) {
    if (error is FirebaseAuthException) {
      return FirebaseFailure.fromFirebaseAuthException(error);
    } else if (error is FirebaseException &&
        error.plugin == 'cloud_firestore') {
      return FirebaseFailure.fromFirestoreException(error);
    } else if (error is FirebaseException) {
      return FirebaseFailure.fromFirebaseException(error);
    } else {
      return FirebaseFailure('حدث خطأ غير متوقع: $error');
    }
  }
}

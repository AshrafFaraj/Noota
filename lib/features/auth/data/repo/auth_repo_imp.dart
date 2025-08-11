import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/core/errors/failure.dart';
import '/core/services/firebase_auth_services.dart';
import '/features/auth/data/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  const AuthRepoImp(this._firebaseAuthServices);

  final FirebaseAuthServices _firebaseAuthServices;

  @override
  Future<Either<Failure, void>> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuthServices.signIn(email: email, password: password);
      return right(null);
    } on FirebaseAuthException catch (e) {
      // print(
      //     'Auth repo imp !!!!!!!!!!!!!!! ${FirebaseFailure.fromFirebaseAuthException(e).errMessage}');
      return left(FirebaseFailure.fromFirebaseAuthException(e));
    }
  }

  @override
  Future<Either<Failure, void>> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuthServices.signUp(email: email, password: password);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseFailure.fromFirebaseAuthException(e));
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword({required String email}) async {
    try {
      await _firebaseAuthServices.forgetPassword(email: email);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseFailure.fromFirebaseAuthException(e));
    }
  }
}

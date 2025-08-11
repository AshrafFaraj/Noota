import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> signIn(
      {required String email, required String password});
  Future<Either<Failure, void>> signUp(
      {required String email, required String password});
  Future<Either<Failure, void>> forgetPassword({required String email});
}

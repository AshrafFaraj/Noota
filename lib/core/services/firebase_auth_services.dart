import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  final _auth = FirebaseAuth.instance;

  FirebaseAuthServices();

  Future<dynamic> signIn(
      {required String email, required String password}) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }

  Future<void> forgetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user!.sendEmailVerification();
    return credential;
  }
}

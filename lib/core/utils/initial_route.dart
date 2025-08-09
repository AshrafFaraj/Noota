import 'package:firebase_auth/firebase_auth.dart';

String initialRoute() {
  if (FirebaseAuth.instance.currentUser != null &&
      FirebaseAuth.instance.currentUser!.emailVerified) {
    return 'home';
  }
  return 'signin';
}

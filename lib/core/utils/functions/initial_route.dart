import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/core/constants/app_route_name.dart';

String initialRoute() {
  if (FirebaseAuth.instance.currentUser != null &&
      FirebaseAuth.instance.currentUser!.emailVerified) {
    return AppRouteName.home;
  }
  return AppRouteName.signIn;
}

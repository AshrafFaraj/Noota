import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '/firebase_options.dart';
import 'core/utils/functions/initial_route.dart';
import 'core/utils/my_routes.dart';
import 'core/utils/my_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // options: const FirebaseOptions(
    //   apiKey: 'any', // لا يهم لأننا نستخدم المحاكي
    //   appId: '1:1234567890:android:abc123def456', // أي قيمة صالحة
    //   messagingSenderId: '1234567890', // قيمة وهمية
    //   projectId: 'demo-project', // يجب أن تتطابق مع projectId في firebase.json
    // ),
  );

  // if (kDebugMode) {
  //   // ربط Firestore بالمحاكي
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  //   FirebaseFirestore.instance.settings = const Settings(
  //     persistenceEnabled: false,
  //   );
  //   // ربط Auth بالمحاكي
  //   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // }
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('-------------------User is currently signed out!');
      } else {
        print('--------------------User is signed in!');
      }
    });

    return MaterialApp(
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute(),
        routes: myRoutes);
  }
}

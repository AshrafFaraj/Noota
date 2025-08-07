import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/features/categories/edit_category.dart';
import 'package:note_app/firebase_options.dart';
import '/app_color.dart';
import '/features/categories/add_category.dart';
import '/features/auth/views/signin_view.dart';
import '/features/auth/views/signup_view.dart';
import 'features/home/home_view.dart';

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
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: AppColor.primary),
              titleTextStyle: TextStyle(
                  color: AppColor.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500))),
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? HomeView()
          : SignInView(),
      routes: {
        'signin': (context) => SignInView(),
        'signup': (context) => SignUpView(),
        'home': (context) => HomeView(),
        'add': (context) => AddCategory(),
        'edit': (context) => EditCategory(),
      },
    );
  }
}

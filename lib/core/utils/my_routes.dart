import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_route_name.dart';
import '/core/services/firebase_auth_services.dart';
import '/features/auth/data/repo/auth_repo_imp.dart';
import '/features/auth/presentation/manager/cubit_auth/auth_cubit.dart';
import '../../features/auth/presentation/view/pages/signin_view.dart';
import '../../features/auth/presentation/view/pages/signup_view.dart';
import '../../features/home/data/repo/home_repo_imp.dart';
import '../../features/home/presentation/view/pages/home_view.dart';
import '../../features/home/presentation/manager/categories_cubit/categories_cubit.dart';
import '../services/firestore_services.dart';

Map<String, Widget Function(BuildContext)> myRoutes = {
  AppRouteName.signIn: (context) => BlocProvider(
        create: (context) => AuthCubit(AuthRepoImp(FirebaseAuthServices())),
        child: SignInView(),
      ),
  AppRouteName.signUp: (context) => BlocProvider(
        create: (context) => AuthCubit(AuthRepoImp(FirebaseAuthServices())),
        child: SignUpView(),
      ),
  AppRouteName.home: (context) => BlocProvider(
        create: (context) => CategoriesCubit(
            homeRepo: HomeRepoImp(firestoreService: FirestoreService()))
          ..fetchCategories(),
        child: HomeView(),
      ),
};

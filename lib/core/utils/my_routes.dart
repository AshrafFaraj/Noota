import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/views/signin_view.dart';
import '../../features/auth/views/signup_view.dart';
import '../../features/home/data/repo/home_repo_imp.dart';
import '../../features/home/home_view.dart';
import '../../features/home/manager/categories_cubit/categories_cubit.dart';
import 'firebase_services.dart';

Map<String, Widget Function(BuildContext)> myRoutes = {
  'signin': (context) => SignInView(),
  'signup': (context) => SignUpView(),
  'home': (context) => BlocProvider(
        create: (context) => CategoriesCubit(
            homeRepo: HomeRepoImp(firestoreService: FirestoreService()))
          ..fetchCategories(),
        child: HomeView(),
      ),
};

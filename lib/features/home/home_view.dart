import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/custom_bottom_sheet.dart';
import '../../core/utils/app_color.dart';
import 'manager/categories_cubit/categories_cubit.dart';
import 'widgets/home_grid_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController categoryController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    categoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('signin');
              },
              icon: Icon(
                Icons.exit_to_app,
                size: 20,
              ))
        ],
        title: Text(
          'Home Page',
        ),
      ),
      body: Home_GridView(
        categoryController: categoryController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          categoryController.clear();
          customBottomSheet(
              context: context,
              bottonTitel: 'اضافة القسم',
              hint: 'ادخل اسم القسم الجديد',
              controller: categoryController,
              onPressed: () {
                context
                    .read<CategoriesCubit>()
                    .addCategory(newCategory: categoryController.text);
                Navigator.pop(context);
              });
        },
        backgroundColor: AppColor.secondColor,
        child: Icon(
          Icons.add,
          color: AppColor.white,
          size: 35,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/sign_out_button.dart';
import '../widgets/theme_switcher_button.dart';
import '/features/settings/theme_cubit/theme_cubit.dart';
import '/features/settings/theme_cubit/theme_state.dart';
import '../widgets/custom_category_bottom_sheet.dart';
import '../../../../../core/utils/app_color.dart';
import '../../manager/categories_cubit/categories_cubit.dart';
import '../widgets/home_grid_view.dart';

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
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state is DarkThemeState;
        return Scaffold(
          appBar: AppBar(
            actions: [ThemeSwitcherButton(isDark: isDark), SignOutButton()],
            title: Text(
              'الصفحة الرئيسية',
            ),
          ),
          body: HomeGridView(
            categoryController: categoryController,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              categoryController.clear();
              customCategoryBottomSheet(
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
            child: Icon(
              Icons.add,
              color: AppColors.white,
              size: 35,
            ),
          ),
        );
      },
    );
  }
}

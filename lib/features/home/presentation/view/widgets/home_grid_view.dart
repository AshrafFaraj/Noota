import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/custom_bottom_sheet.dart';
import '../../../../../core/services/firestore_services.dart';
import '../../../../notes/data/repo/note_repo_imp.dart';
import '../../../../notes/presentation/manager/notes_cubit/notes_cubit.dart';
import '../../../../notes/presentation/view/pages/notes_view.dart';
import '../../manager/categories_cubit/categories_cubit.dart';
import 'home_crad.dart';

class Home_GridView extends StatelessWidget {
  const Home_GridView({
    super.key,
    required this.categoryController,
  });

  final TextEditingController categoryController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        if (state is CategoryAddSuccess) {
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  title: 'تم اضافة القسم بنجاح')
              .show();
        } else if (state is CategoryDeleteSuccess) {
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  title: 'تم الحذف بنجاح')
              .show();
        } else if (state is CategoryEditSuccess) {
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  title: 'تم التعديل بنجاح')
              .show();
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<CategoriesCubit>(context);
        if (state is CategoriesLoaded) {
          return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                var category = state.categories[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => NotesCubit(
                                    noteRepo: NoteRepoImp(
                                        firestoreService: FirestoreService()))
                                  ..fetchNotes(docId: category.id),
                                child: NotesView(
                                    name: category.name, docId: category.id),
                              )));
                    },
                    onLongPress: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.bottomSlide,
                        btnOkText: 'تعديل',
                        btnOkColor: AppColor.primary,
                        btnOkOnPress: () {
                          categoryController.text = category.name;
                          customBottomSheet(
                              context: context,
                              bottonTitel: 'تعديل القسم',
                              controller: categoryController,
                              onPressed: () {
                                Navigator.pop(context);
                                cubit.editCategory(
                                    docId: category.id,
                                    newCategory: categoryController.text);
                              });
                        },
                        btnCancelText: 'حذف',
                        btnCancelOnPress: () {
                          cubit.deleteCategory(docId: category.id);
                        },
                      ).show();
                    },
                    child: HomeCard(title: category.name));
              });
        } else if (state is CategoriesFailure) {
          return Center(
            child: Text(state.errMessage),
          );
        } else if (state is CategoriesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

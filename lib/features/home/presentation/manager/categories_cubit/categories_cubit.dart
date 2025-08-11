import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/features/home/data/models/category_model.dart';
import 'package:note_app/features/home/data/repo/home_repo.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required this.homeRepo}) : super(CategoriesInitial());
  HomeRepo homeRepo;

  List<CategoryModel> _categories = [];

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    final result = await homeRepo.fetchCategories();
    result.fold(
      (failure) => emit(CategoriesFailure(errMessage: failure.errMessage)),
      (cats) {
        _categories = cats;
        emit(CategoriesLoaded(categories: List.from(_categories)));
      },
    );
  }

  Future<void> addCategory({required String newCategory}) async {
    emit(CategoriesLoading());
    final result = await homeRepo.addCategory(newCategory: newCategory);
    result.fold(
      (failure) => emit(CategoriesFailure(errMessage: failure.errMessage)),
      (newCat) {
        _categories.add(newCat);
        emit(CategoryAddSuccess());
        emit(CategoriesLoaded(categories: List.from(_categories)));
      },
    );
  }

  Future<void> editCategory(
      {required String docId, required String newCategory}) async {
    emit(CategoriesLoading());
    final result =
        await homeRepo.editCategory(docId: docId, newCategory: newCategory);
    result.fold(
      (failure) => emit(CategoriesFailure(errMessage: failure.errMessage)),
      (_) {
        final index = _categories.indexWhere((c) => c.id == docId);
        if (index != -1) {
          _categories[index].setName = newCategory;
          emit(CategoryEditSuccess());
          emit(CategoriesLoaded(categories: List.from(_categories)));
        }
      },
    );
  }

  Future<void> deleteCategory({required String docId}) async {
    emit(CategoriesLoading());
    final result = await homeRepo.deleteCategory(docId: docId);
    result.fold(
      (failure) => emit(CategoriesFailure(errMessage: failure.errMessage)),
      (_) {
        _categories.removeWhere((c) => c.id == docId);
        emit(CategoryDeleteSuccess());
        emit(CategoriesLoaded(categories: List.from(_categories)));
      },
    );
  }
}

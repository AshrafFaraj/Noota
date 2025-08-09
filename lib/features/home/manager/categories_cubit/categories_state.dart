part of 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesLoaded extends CategoriesState {
  final List<CategoryModel> categories;

  const CategoriesLoaded({required this.categories});
}

final class CategoriesFailure extends CategoriesState {
  final String errMessage;

  const CategoriesFailure({required this.errMessage});
}

final class CategoryAddSuccess extends CategoriesState {}

final class CategoryEditSuccess extends CategoriesState {}

final class CategoryDeleteSuccess extends CategoriesState {}

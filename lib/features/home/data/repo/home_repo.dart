import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:note_app/core/errors/failure.dart';

import '../models/category_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CategoryModel>>> fetchCategories();
  Future<Either<Failure, CategoryModel>> addCategory({
    required String newCategory,
  });
  Future<Either<Failure, void>> editCategory({
    required String docId,
    required String newCategory,
  });
  Future<Either<Failure, void>> deleteCategory({
    required String docId,
  });
}

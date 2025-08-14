import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/core/errors/failure.dart';
import '/core/constants/firestore_collections_path.dart';
import '/core/services/firestore_services.dart';
import '/features/home/data/models/category_model.dart';
import '/features/home/data/repo/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final FirestoreService firestoreService;

  HomeRepoImp({required this.firestoreService});

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchCategories() async {
    try {
      final response = await firestoreService.getDocuments(
        collectionPath: FirestoreCollecPath.categoriesCollec,
      ); // QuerySnapshot<Map<String,dynamic>>
      final categories = response.docs
          .map((d) => CategoryModel.fromQueryDocumentSnapshot(d))
          .toList();
      return right(categories);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.fromFirestoreException(e));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> addCategory(
      {required String newCategory}) async {
    try {
      // firestoreService.addDocument returns DocumentReference
      final docRef = await firestoreService.addDocument(
        collectionPath: FirestoreCollecPath.categoriesCollec,
        data: {
          'name': newCategory,
          'uid': FirebaseAuth.instance.currentUser!.uid,
        },
      ); // DocumentReference<Map<String,dynamic>>
      final docSnap =
          await docRef.get(); // DocumentSnapshot<Map<String,dynamic>>
      final category = CategoryModel.fromDocumentSnapshot(docSnap);
      return right(category);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.fromFirestoreException(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory({required String docId}) async {
    try {
      await firestoreService.deleteDocument(docId: docId);
      return right(null);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.fromFirestoreException(e));
    }
  }

  @override
  Future<Either<Failure, void>> editCategory(
      {required String docId, required String newCategory}) async {
    try {
      await firestoreService
          .editDocument(docId: docId, data: {'name': newCategory});
      return right(null);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.fromFirestoreException(e));
    }
  }
}

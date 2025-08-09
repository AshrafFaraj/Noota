import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/core/errors/failure.dart';
import 'package:note_app/core/utils/firestore_collections_path.dart';
import 'package:note_app/core/utils/firebase_services.dart';
import 'package:note_app/features/home/data/models/category_model.dart';
import 'package:note_app/features/home/data/repo/home_repo.dart';

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
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirebaseFailure.fromFirebaseException(e));
      }
      return left(FirebaseFailure(e.toString()));
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
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirebaseFailure.fromFirebaseException(e));
      }
      return left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory({required String docId}) async {
    try {
      await firestoreService.deleteDocument(
          collectionPath: FirestoreCollecPath.categoriesCollec, docId: docId);
      return right(null);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirebaseFailure.fromFirebaseException(e));
      }
      return left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editCategory(
      {required String docId, required String newCategory}) async {
    try {
      await firestoreService.editDocument(
          collectionPath: FirestoreCollecPath.categoriesCollec,
          docId: docId,
          data: {'name': newCategory});
      return right(null);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirebaseFailure.fromFirebaseException(e));
      }
      return left(FirebaseFailure(e.toString()));
    }
  }
}

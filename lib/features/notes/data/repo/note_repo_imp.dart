import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:note_app/features/notes/data/models/note_mode.dart';
import '/core/errors/failure.dart';
import '../../../../core/services/firestore_services.dart';
import '/features/notes/data/repo/note_repo.dart';

class NoteRepoImp implements NoteRepo {
  NoteRepoImp({required this.firestoreService});

  final FirestoreService firestoreService;

  @override
  Future<Either<Failure, List<NoteModel>>> fetchNotes(
      {required String collectionPath,
      required String subCollectionPath,
      required String docId}) async {
    try {
      final response = await firestoreService.getSubDocuments(
          collectionPath: collectionPath,
          docId: docId,
          subCollectionPath: subCollectionPath);

      final notes = response.docs
          .map(
            (e) => NoteModel.fromQueryDocumentSnapshot(e),
          )
          .toList();
      return right(notes);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirebaseFailure.fromFirebaseException(e));
      }
      return left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NoteModel>> addNote(
      {required String collectionPath,
      required String subCollectionPath,
      required String docId,
      required String newNote}) async {
    try {
      final docRef = await firestoreService.addSubDocument(
          collectionPath: collectionPath,
          docId: docId,
          subCollectionPath: subCollectionPath,
          data: {'desc': newNote});
      final docSnap = await docRef.get();
      final note = NoteModel.fromDocumentSnapshot(docSnap);

      return right(note);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirebaseFailure.fromFirebaseException(e));
      }
      return left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(
      {required String collectionPath,
      required String subCollectionPath,
      required String docId,
      required String subDocId}) async {
    try {
      await firestoreService.deleteSubDocument(
          collectionPath: collectionPath,
          docId: docId,
          subCollectionPath: subCollectionPath,
          subDocId: subDocId);
      return right(null);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirebaseFailure.fromFirebaseException(e));
      }
      return left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editNote(
      {required String collectionPath,
      required String subCollectionPath,
      required String docId,
      required String subDocId,
      required String newNote}) async {
    try {
      await firestoreService.editSubDocument(
          collectionPath: collectionPath,
          docId: docId,
          subCollectionPath: subCollectionPath,
          subDocId: subDocId,
          data: {'desc': newNote});
      return right(null);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirebaseFailure.fromFirebaseException(e));
      }
      return left(FirebaseFailure(e.toString()));
    }
  }
}

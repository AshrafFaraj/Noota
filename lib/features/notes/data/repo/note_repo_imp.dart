import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '/features/notes/data/models/note_mode.dart';
import '../../../../core/services/firebase_storage_services.dart';
import '/core/errors/failure.dart';
import '../../../../core/services/firestore_services.dart';
import '/features/notes/data/repo/note_repo.dart';

class NoteRepoImp implements NoteRepo {
  NoteRepoImp({required this.firestoreService});

  final FirestoreService firestoreService;
  final _storage = StorageService();

  @override
  Future<Either<Failure, List<NoteModel>>> fetchNotes(
      {required String docId}) async {
    try {
      final response = await firestoreService.getSubDocuments(
        docId: docId,
      );
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
      {required String docId, required String newNote, XFile? xfile}) async {
    try {
      String? imageUrl;

      if (xfile != null) {
        // 2. ضغط الصورة
        // final compressedFile =
        //     await _imageCompressionService.compressXFile(xfile);
        // if (compressedFile != null) {
        // 3. رفع الصورة
        imageUrl = await _storage.uploadImage(
          xfile,
        );
      }
      final docRef = await firestoreService.addSubDocument(docId: docId, data: {
        'note': newNote,
        'imageUrl': imageUrl ?? 'none',
      });

      final docSnap = await docRef.get();
      final note = NoteModel.fromDocumentSnapshot(docSnap);

      return right(note);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.fromFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(
      {required String docId,
      required String subDocId,
      required String imageUrl}) async {
    try {
      await firestoreService.deleteSubDocument(
          docId: docId, subDocId: subDocId);
      if (imageUrl != 'none') {
        await _storage.deleteImageByUrl(imageUrl);
      }
      return right(null);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirebaseFailure.fromFirebaseException(e));
      }
      return left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editNote({
    required String docId,
    required String subDocId,
    required Map<String, dynamic> newData,
  }) async {
    try {
      await firestoreService.editSubDocument(
          docId: docId, subDocId: subDocId, data: newData);
      return right(null);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirebaseFailure.fromFirebaseException(e));
      }
      return left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> editNoteImage({
    required String imageUrl,
    required XFile newFile,
  }) async {
    try {
      final downloadUrl = await _storage.updateImage(imageUrl, newFile);
      return right(downloadUrl);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.fromFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNoteImage({
    required String docId,
    required String subDocId,
    required String imageUrl,
  }) async {
    try {
      await _storage.deleteImageByUrl(imageUrl);
      return right(null);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.fromFirebaseException(e));
    }
  }
}

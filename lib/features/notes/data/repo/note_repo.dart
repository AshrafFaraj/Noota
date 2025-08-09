import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:note_app/features/notes/data/models/note_mode.dart';
import '/core/errors/failure.dart';

abstract class NoteRepo {
  Future<Either<Failure, List<NoteModel>>> fetchNotes({
    required String collectionPath,
    required String subCollectionPath,
    required String docId,
  });
  Future<Either<Failure, NoteModel>> addNote({
    required String collectionPath,
    required String subCollectionPath,
    required String docId,
    required String newNote,
  });
  Future<Either<Failure, void>> editNote({
    required String collectionPath,
    required String subCollectionPath,
    required String docId,
    required String subDocId,
    required String newNote,
  });
  Future<Either<Failure, void>> deleteNote({
    required String collectionPath,
    required String subCollectionPath,
    required String docId,
    required String subDocId,
  });
}

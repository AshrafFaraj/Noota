import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import '/features/notes/data/models/note_mode.dart';
import '/core/errors/failure.dart';

abstract class NoteRepo {
  Future<Either<Failure, List<NoteModel>>> fetchNotes({
    required String docId,
  });
  Future<Either<Failure, NoteModel>> addNote(
      {required String docId, required String newNote, XFile? xfile});
  Future<Either<Failure, void>> editNote({
    required String docId,
    required String subDocId,
    required Map<String, dynamic> newData,
  });

  Future<Either<Failure, void>> deleteNote(
      {required String docId,
      required String subDocId,
      required String imageUrl});

  Future<Either<Failure, String>> editNoteImage({
    required String imageUrl,
    required XFile newFile,
  });
  Future<Either<Failure, void>> deleteNoteImage({
    required String docId,
    required String subDocId,
    required String imageUrl,
  });
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/core/constants/firestore_collections_path.dart';
import 'package:note_app/features/notes/data/models/note_mode.dart';
import '/features/notes/data/repo/note_repo.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit({required this.noteRepo}) : super(NotesInitial());

  NoteRepo noteRepo;
  List<NoteModel> _notes = [];

  Future<void> fetchNotes({
    required String docId,
  }) async {
    emit(NotesLoading());
    final result = await noteRepo.fetchNotes(
        collectionPath: FirestoreCollecPath.categoriesCollec,
        subCollectionPath: FirestoreCollecPath.noteSubCollec,
        docId: docId);

    result.fold((failure) {
      emit(NotesFailure(errMessage: failure.errMessage));
    }, (notes) {
      _notes = notes;
      emit(NotesLoaded(notes: List.from(_notes)));
    });
  }

  Future<void> addNote({
    required String docId,
    required String newNote,
  }) async {
    emit(NotesLoading());
    final result = await noteRepo.addNote(
        collectionPath: FirestoreCollecPath.categoriesCollec,
        subCollectionPath: FirestoreCollecPath.noteSubCollec,
        docId: docId,
        newNote: newNote);

    result.fold((failure) {
      emit(NotesFailure(errMessage: failure.errMessage));
    }, (note) {
      _notes.add(note);
      emit(NotesAddSuccess());
      emit(NotesLoaded(notes: _notes));
    });
  }

  Future<void> editNote({
    required String docId,
    required String subDocId,
    required String newNote,
  }) async {
    emit(NotesLoading());
    final result = await noteRepo.editNote(
        collectionPath: FirestoreCollecPath.categoriesCollec,
        subCollectionPath: FirestoreCollecPath.noteSubCollec,
        docId: docId,
        subDocId: subDocId,
        newNote: newNote);

    result.fold((failure) {
      emit(NotesFailure(errMessage: failure.errMessage));
    }, (_) {
      int index = _notes.indexWhere((e) => e.id == subDocId);
      if (index != -1) {
        _notes[index].setNote = newNote;
      }
      emit(NotesEditSuccess());
      emit(NotesLoaded(notes: List.from(_notes)));
    });
  }

  Future<void> deleteNote({
    required String docId,
    required String subDocId,
  }) async {
    emit(NotesLoading());
    final result = await noteRepo.deleteNote(
        collectionPath: FirestoreCollecPath.categoriesCollec,
        subCollectionPath: FirestoreCollecPath.noteSubCollec,
        docId: docId,
        subDocId: subDocId);

    result.fold((failure) {
      emit(NotesFailure(errMessage: failure.errMessage));
    }, (_) {
      _notes.removeWhere((e) => e.id == subDocId);
      emit(NotesDeleteSuccess());
      emit(NotesLoaded(notes: List.from(_notes)));
    });
  }
}

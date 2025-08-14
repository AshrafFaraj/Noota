import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '/features/notes/data/models/note_mode.dart';
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
    final result = await noteRepo.fetchNotes(docId: docId);

    result.fold((failure) {
      emit(NotesFailure(errMessage: failure.errMessage));
    }, (notes) {
      _notes = notes;
      emit(NotesLoaded(notes: List.from(_notes)));
    });
  }

  Future<void> addNote(
      {required String docId, required String newNote, XFile? xfile}) async {
    emit(NotesLoading());
    final result =
        await noteRepo.addNote(docId: docId, newNote: newNote, xfile: xfile);

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
    required Map<String, dynamic> newData,
  }) async {
    emit(NotesLoading());
    final result = await noteRepo.editNote(
        docId: docId, subDocId: subDocId, newData: newData);

    result.fold((failure) {
      emit(NotesFailure(errMessage: failure.errMessage));
    }, (_) {
      editLocalListNote(subDocId: subDocId, newData: newData);
      emit(NotesEditSuccess(subDocId)); // تعديل هنا
      emit(NotesLoaded(
          notes: List.from(_notes), updatedId: subDocId)); // تعديل هنا
    });
  }

  Future<void> deleteNote(
      {required String docId,
      required String subDocId,
      required String imageUrl}) async {
    emit(NotesLoading());
    final result = await noteRepo.deleteNote(
        docId: docId, subDocId: subDocId, imageUrl: imageUrl);

    result.fold((failure) {
      emit(NotesFailure(errMessage: failure.errMessage));
    }, (_) {
      _notes.removeWhere((e) => e.id == subDocId);
      emit(NotesDeleteSuccess());
      emit(NotesLoaded(notes: List.from(_notes)));
    });
  }

  Future<void> editNoteImage({
    required String docId,
    required String subDocId,
    required String imageUrl,
    required XFile newFile,
  }) async {
    final result =
        await noteRepo.editNoteImage(imageUrl: imageUrl, newFile: newFile);
    result.fold((failure) {
      emit(NotesFailure(errMessage: failure.errMessage));
    }, (url) async {
      await editNote(
          docId: docId, subDocId: subDocId, newData: {'imageUrl': url});
    });
  }

  Future<void> deletNoteImage({
    required String docId,
    required String subDocId,
    required String imageUrl,
  }) async {
    final result = await noteRepo.deleteNoteImage(
        docId: docId, subDocId: subDocId, imageUrl: imageUrl);
    result.fold((failure) {
      emit(NotesFailure(errMessage: failure.errMessage));
    }, (_) async {
      await editNote(
          docId: docId, subDocId: subDocId, newData: {'imageUrl': 'none'});
    });
  }

  void editLocalListNote({
    required String subDocId,
    required Map<String, dynamic> newData,
  }) {
    _notes = _notes.map((note) {
      if (note.id != subDocId) return note;
      return note.copyWith(
        note: newData['note'] as String?,
        imageUrl: newData['imageUrl'] as String?,
      );
    }).toList();
  }
}

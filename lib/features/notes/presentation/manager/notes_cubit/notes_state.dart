part of 'notes_cubit.dart';

sealed class NotesState {
  const NotesState();

  // @override
  // List<Object> get props => [];
}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}

final class NotesAddSuccess extends NotesState {}

final class NotesEditSuccess extends NotesState {
  final String updatedId; // أضف هذا
  const NotesEditSuccess(this.updatedId);
}

final class NotesDeleteSuccess extends NotesState {}

final class NotesLoaded extends NotesState {
  final List<NoteModel> notes;
  final String? updatedId; // أضف هذا

  const NotesLoaded({required this.notes, this.updatedId});
  // @override
  // List<Object> get props => [notes, updatedId ?? ''];
}

final class NotesFailure extends NotesState {
  final String errMessage;

  const NotesFailure({required this.errMessage});
}

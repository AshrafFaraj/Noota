part of 'notes_cubit.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}

final class NotesAddSuccess extends NotesState {}

final class NotesEditSuccess extends NotesState {}

final class NotesDeleteSuccess extends NotesState {}

final class NotesLoaded extends NotesState {
  final List<NoteModel> notes;

  const NotesLoaded({required this.notes});
}

final class NotesFailure extends NotesState {
  final String errMessage;

  const NotesFailure({required this.errMessage});
}

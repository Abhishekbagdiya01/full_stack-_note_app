part of 'note_cubit.dart';

@immutable
sealed class NoteState extends Equatable {}

class NoteInitial extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteLoading extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteLoaded extends NoteState {
  final List<NoteModel> arrNotes;
  NoteLoaded(this.arrNotes);
  @override
  List<Object?> get props => [arrNotes];
}

class NoteAddedState extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteUpdateState extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteError extends NoteState {
  String errorMessage;
  NoteError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

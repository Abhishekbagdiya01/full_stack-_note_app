import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';
import 'package:note_app/repository/network_repository.dart';

import '../../models/note_model.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  NetworkRepository networkRepository = NetworkRepository();
  Future getMyNotes(NoteModel noteModel) async {
    emit(NoteLoading());
    try {
      final arrNotes = await networkRepository.fetchMyNotes(noteModel);

      emit(NoteLoaded(arrNotes));
    } catch (e) {
      emit(NoteError(errorMessage: e.toString()));
    }
  }

  Future addNote(NoteModel noteModel) async {
    emit(NoteLoading());
    try {
      await networkRepository.addNote(noteModel);
      emit(NoteAddedState());
    } catch (e) {
      emit(NoteError(errorMessage: e.toString()));
    }
  }

  Future updateNote(NoteModel noteModel) async {
    emit(NoteLoading());
    try {
      await networkRepository.updateNote(noteModel);
      emit(NoteUpdateState());
    } catch (e) {
      emit(NoteError(errorMessage: e.toString()));
    }
  }

  Future deleteNote(NoteModel noteModel) async {
    emit(NoteLoading());
    try {
      await networkRepository.delateNote(noteModel);
    } catch (e) {
      emit(NoteError(errorMessage: e.toString()));
    }
  }
}

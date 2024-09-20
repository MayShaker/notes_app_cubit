
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/get_note_repo.dart';
import 'get_state.dart';


class GetNotesCubit extends Cubit<GetNotesState> {
  final GetNoteRepository notesRepository;

  GetNotesCubit(this.notesRepository) : super(GetNotesInitial());

  Future<void> fetchNotes() async {
    emit(GetNotesLoading());

    try {
      final notes = await notesRepository.getNotes();
      emit(GetNotesSuccess(notes)); 
    } catch (e) {
      emit(GetNotesFailure("An error occurred while fetching notes."));
    }
  }
}

// create_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/create_note_req.dart';
import '../../models/get_note_res.dart';
import '../../repositories/create_note_repo.dart';
import 'create_state.dart';

class CreateNoteCubit extends Cubit<CreateNoteState> {
  final CreateNoteRepository notesRepository;

  CreateNoteCubit(this.notesRepository) : super(CreateNoteInitial());

  Future<void> createNote({
    required String category,
    required String title,
    required String text,
  }) async {
    emit(CreateNoteLoading());
    try {
      
      CreateNoteRequest request = CreateNoteRequest(
        category: category,
        title: title,
        text: text,
      );
      
      
      Note createdNote = await notesRepository.createNote(request);
      emit(CreateNoteSuccess("Note created successfully"));
    } catch (e) {
      emit(CreateNoteFailure("Failed to create note: ${e.toString()}"));
    }
  }
}

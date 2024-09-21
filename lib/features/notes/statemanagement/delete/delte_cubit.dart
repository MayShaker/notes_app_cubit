import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/delete_rep.dart';
import 'delete_state.dart';

class DeleteNoteCubit extends Cubit<DeleteNoteState> {
  final DeleteNoteRepository deleteNoteRepository;

  DeleteNoteCubit(this.deleteNoteRepository) : super(DeleteNoteInitial());

  Future<void> deleteNoteById(String noteId) async {
    emit(DeleteNoteLoading());
    final response = await deleteNoteRepository.deleteNoteById(noteId);

    if (response.statusCode == 200) {
      emit(DeleteNoteSuccess(response.message));
    } else {
      emit(DeleteNoteFailure(response.message ?? 'Error deleting note'));
    }
  }
}

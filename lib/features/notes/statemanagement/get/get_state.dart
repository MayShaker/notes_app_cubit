

import 'package:equatable/equatable.dart';


import '../../models/get_note_res.dart';

abstract class GetNotesState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetNotesInitial extends GetNotesState {}

class GetNotesLoading extends GetNotesState {}

class GetNotesSuccess extends GetNotesState {
  final List<Note> notes;

  GetNotesSuccess(this.notes);

  @override
  List<Object> get props => [notes];
}

/*class GetNotesError extends GetNotesState {
  final String message;

  GetNotesError(this.message);

  @override
  List<Object> get props => [message];
}*/
class GetNotesFailure extends GetNotesState {
  final String error;

  GetNotesFailure(this.error);
}

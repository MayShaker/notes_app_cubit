

import 'package:equatable/equatable.dart';


abstract class CreateNoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateNoteInitial extends CreateNoteState {}

class CreateNoteLoading extends CreateNoteState {}

class CreateNoteSuccess extends CreateNoteState {
  final String message;

  CreateNoteSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateNoteFailure extends CreateNoteState {
  final String error;

  CreateNoteFailure(this.error);

  @override
  List<Object?> get props => [error];
}

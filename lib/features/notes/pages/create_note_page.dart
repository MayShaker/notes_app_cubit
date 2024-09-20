// create_note_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../statemanagement/create/create_cubit.dart';
import '../statemanagement/create/create_state.dart';

class CreateNotePage extends StatelessWidget {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<CreateNoteCubit, CreateNoteState>(
          listener: (context, state) {
            if (state is CreateNoteSuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Note created successfully')),
              );
            } else if (state is CreateNoteFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is CreateNoteLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                TextField(controller: _categoryController, decoration: InputDecoration(labelText: 'Category')),
                TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Title')),
                TextField(controller: _textController, decoration: InputDecoration(labelText: 'Text'), maxLines: 5),
                ElevatedButton(
                  onPressed: () {
                    context.read<CreateNoteCubit>().createNote(
                      category: _categoryController.text,
                      title: _titleController.text,
                      text: _textController.text,
                    );
                  },
                  child: Text('Create Note'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

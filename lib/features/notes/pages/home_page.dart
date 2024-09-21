import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/create_note_repo.dart';
import '../repositories/delete_rep.dart';
import '../statemanagement/create/create_cubit.dart';
import '../statemanagement/create/create_state.dart';
import '../statemanagement/delete/delete_state.dart';
import '../statemanagement/delete/delte_cubit.dart';
import '../statemanagement/get/get_cubit.dart';
import '../statemanagement/get/get_state.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch notes when the HomePage is built
    context.read<GetNotesCubit>().fetchNotes();

    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: MultiBlocListener(
        listeners: [
          // Listen for note deletion success/failure
          BlocListener<DeleteNoteCubit, DeleteNoteState>(
            listener: (context, state) {
              if (state is DeleteNoteSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                // Refresh notes after deletion
                context.read<GetNotesCubit>().fetchNotes();
              } else if (state is DeleteNoteFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<GetNotesCubit, GetNotesState>(
          builder: (context, state) {
            if (state is GetNotesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetNotesSuccess) {
              if (state.notes.isEmpty) {
                return Center(child: Text('No notes available'));
              }
              return ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.text),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(note.category),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _showDeleteNoteDialog(context, note.id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is GetNotesFailure) {
              return Center(child: Text('Failed to fetch notes: ${state.error}'));
            } else {
              return Center(child: Text('No notes available'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateNoteDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showCreateNoteDialog(BuildContext context) {
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => CreateNoteCubit(
            RepositoryProvider.of<CreateNoteRepository>(context),
          ),
          child: AlertDialog(
            title: Text('Create Note'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: textController,
                  decoration: InputDecoration(labelText: 'Text'),
                  maxLines: 4,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              BlocConsumer<CreateNoteCubit, CreateNoteState>(
                listener: (context, state) {
                  if (state is CreateNoteSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                    Navigator.pop(context);
                    context.read<GetNotesCubit>().fetchNotes(); // Refresh notes after creation
                  } else if (state is CreateNoteFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  return TextButton(
                    onPressed: () {
                      context.read<CreateNoteCubit>().createNote(
                        category: categoryController.text,
                        title: titleController.text,
                        text: textController.text,
                      );
                    },
                    child: state is CreateNoteLoading
                        ? CircularProgressIndicator()
                        : Text('Create'),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteNoteDialog(BuildContext context, String noteId) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => DeleteNoteCubit(
            RepositoryProvider.of<DeleteNoteRepository>(context),
          ),
          child: AlertDialog(
            title: Text('Delete Note'),
            content: Text('Are you sure you want to delete this note?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.read<DeleteNoteCubit>().deleteNoteById(noteId);
                  Navigator.pop(context);
                },
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
    );
  }
}

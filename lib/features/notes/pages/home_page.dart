import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../statemanagement/get/get_cubit.dart';
import '../statemanagement/get/get_state.dart';
import 'create_note_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: BlocBuilder<GetNotesCubit, GetNotesState>(
        builder: (context, state) {
          if (state is GetNotesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetNotesSuccess) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.text),
                  trailing: Text(note.category),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNotePage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

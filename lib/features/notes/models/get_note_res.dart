class GetNotesResponse {
  final int statusCode;
  final String message;
  final List<Note> notes;

  GetNotesResponse({
    required this.statusCode,
    required this.message,
    required this.notes,
  });

  factory GetNotesResponse.fromJson(Map<String, dynamic> json) {
    var notesJson = json['data']['notes'] as List;
    List<Note> notesList = notesJson.map((noteJson) => Note.fromJson(noteJson)).toList();

    return GetNotesResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      notes: notesList,
    );
  }
}

class Note {
  final String id;
  final String category;
  final String title;
  final String text;
  final String user;

  Note({
    required this.id,
    required this.category,
    required this.title,
    required this.text,
    required this.user,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'],
      category: json['category'],
      title: json['title'],
      text: json['text'],
      user: json['user'],
    );
  }
}

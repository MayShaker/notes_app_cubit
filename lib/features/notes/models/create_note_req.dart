// create_note_request.dart

class CreateNoteRequest {
  final String category;
  final String title;
  final String text;

  CreateNoteRequest({
    required this.category,
    required this.title,
    required this.text,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'title': title,
      'text': text,
    };
  }
}

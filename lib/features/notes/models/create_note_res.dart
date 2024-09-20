class CreateNoteResponse {
  final int statusCode;
  final String message;
  final NoteData? data;

  CreateNoteResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory CreateNoteResponse.fromJson(Map<String, dynamic> json) {
    return CreateNoteResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? NoteData.fromJson(json['data']) : null,
    );
  }
}

class NoteData {
  final String id;
  final String category;
  final String title;
  final String text;
  final String user;

  NoteData({
    required this.id,
    required this.category,
    required this.title,
    required this.text,
    required this.user,
  });

  factory NoteData.fromJson(Map<String, dynamic> json) {
    return NoteData(
      id: json['_id'],
      category: json['category'],
      title: json['title'],
      text: json['text'],
      user: json['user'],
    );
  }
}

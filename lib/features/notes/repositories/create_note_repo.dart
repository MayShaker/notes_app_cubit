import '../../../core/network/api_client.dart';
import '../models/create_note_req.dart';
import '../models/get_note_res.dart';

class CreateNoteRepository {
  final ApiClient apiClient;

  CreateNoteRepository(this.apiClient);

  Future<Note> createNote(CreateNoteRequest request) async {
    final response = await ApiClient.request(
      url: '/notes',
      method: 'POST', // Specify the HTTP method as POST
      data: request.toJson(),
    );
    
    return Note.fromJson(response.data);
  }
}

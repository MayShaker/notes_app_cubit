import '../../../core/network/api_client.dart';
import '../models/get_note_res.dart';

class GetNoteRepository {
  Future<List<Note>> getNotes() async {
    try {
      final response = await ApiClient.request(
        url: '/notes/get-notes',
        method: 'GET',
        withToken: true, 
      );

      if (response.statusCode == 200) {
        final data = response.data['notes'] as List<dynamic>;
        return data.map((e) => Note.fromJson(e)).toList();
      } else {
        throw Exception(response.message); 
      }
    } catch (e) {
      throw Exception('Failed to load notes: $e'); 
    }
  }
}

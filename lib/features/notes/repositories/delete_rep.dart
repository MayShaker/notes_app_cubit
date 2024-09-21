
import '../../../core/network/api_client.dart';
import '../../authentication/models/response_model.dart';

class DeleteNoteRepository {

  Future<ResponseModel> deleteNoteById(String noteId) async {
    final url = '/notes/$noteId';  
    final response = await ApiClient.request(
      url: url,
      method: 'DELETE',
    );
    return response;
  }
}

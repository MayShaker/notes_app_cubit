

import '../../../core/network/api_client.dart';
import '../../authentication/models/response_model.dart';

class DeleteNoteRepository {
  
  Future<ResponseModel> deleteReminder(String reminderId) async {
    try {
      
      final response = await ApiClient.request(
        url: '/reminders/$reminderId',  
        method: 'DELETE',
        withToken: true, 
      );

      // Check the response status code
      if (response.statusCode == 200) {
        return ResponseModel(
          statusCode: 200,
          message: 'Reminder deleted successfully',
        );
      } else {
        // Return the error response from the API
        return ResponseModel(
          statusCode: response.statusCode,
          message: response.message ?? 'Failed to delete the reminder',
        );
      }
    } catch (e) {
      // Handle any exceptions
      return ResponseModel(
        statusCode: 500,
        message: 'An error occurred while deleting the reminder',
      );
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'http://<your_server_ip>:5000/predict';

  Future<Map<String, dynamic>?> uploadImage(File imageFile) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        return jsonDecode(responseData);
      } else {
        print('Failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}

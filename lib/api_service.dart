import 'dart:convert';
import 'package:http/http.dart' as http;
import 'voter.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000/api/voters'; // Make sure this is correct
 // Your Laravel API URL

  Future<List<Voter>> getVoters() async {
    final response = await http.get(Uri.parse(baseUrl));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Debugging line

    if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<Voter> voters = body.map((dynamic item) => Voter.fromJson(item)).toList();
        return voters;
    } else {
        throw Exception('Failed to load voters');
    }
}
}

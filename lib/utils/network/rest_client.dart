import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RestClient {
  RestClient({
    required this.httpClient,
  });
  final Client httpClient;

  Future<http.Response> get({
    required String api,
    String? endpoint,
  }) async {
    final e = endpoint;

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    return httpClient.get(
      Uri.parse('$e$api'),
      headers: headers,
    );
  }
}

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // Process jsonData here.  Add more robust error checking here based on the JSON structure
      print('JSON Data: $jsonData');
    } else {
      throw HttpException('HTTP request failed with status: ${response.statusCode}', response.statusCode);
    }
  } on FormatException catch (e) {
    print('JSON format error: $e');
  } on SocketException catch (e) {
    print('Network error: $e');
  } on HttpException catch (e) {
    print('HTTP error: ${e.message}, Status Code: ${e.statusCode}');
  } catch (e) {
    print('An unexpected error occurred: $e');
  }
}

void main() async {
  await fetchData();
}

class HttpException implements Exception {
  final String message;
  final int statusCode;
  HttpException(this.message, this.statusCode);
}
```
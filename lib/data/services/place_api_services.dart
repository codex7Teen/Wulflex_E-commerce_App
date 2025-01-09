import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class PlaceApiServices {
    static const String _apiKey = "AIzaSyB0q6wk_2WdzLeWqh7dryNePSzEMuhCxfc";
  static const String _baseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";

  Future<List<Map<String, dynamic>>> getSuggestions(String input, String sessionToken) async {
    try {
      final request = '$_baseUrl?input=$input&key=$_apiKey&sessiontoken=$sessionToken';
      final response = await http.get(Uri.parse(request));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['predictions']);
      } else {
        throw Exception('Failed to load place suggestions');
      }
    } catch (error) {
      log('Error fetching suggestions: ${error.toString()}');
      return [];
    }
  }
}
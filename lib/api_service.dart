import 'package:validators/sanitizers.dart';

class ApiServices {
  static const baseUrl = "http://deckofcardsapi.com/api";

  Uri url(String path, [Map<String, dynamic> params = const {}]) {
    String queryString = "";
    if (params.isNotEmpty) {
      queryString = "?";
      params.forEach((key, value) {
        queryString += "$key=${value.toString()}&";
      });
    }

    path = rtrim(path, '/');
    path = ltrim(path, '/');
    queryString = rtrim(queryString, '&');

    final url = "$baseUrl/$path$queryString";
    return Uri.parse(url);
  }
}

import 'package:http/http.dart';

class FetchNews {
  static fetchNews(url) async {
    Response response = await get(Uri.parse(url));
    return response;
  }
}
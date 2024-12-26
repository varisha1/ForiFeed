import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class ArticleService {
  Future<String> fetchArticleContent(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Error: Status code ${response.statusCode}';
      }
    } catch (e) {
      print('Error fetching article: $e');
      return 'Error fetching article';
    }
  }
}

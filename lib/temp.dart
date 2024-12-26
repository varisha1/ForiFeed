import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  // List of RSS Feed URLs
  Map<String, String> rssSources = {
    'https://www.thenews.com.pk/rss/1/10': 'The News International',
    'https://www.thenews.com.pk/rss/1/1': 'The News International',
    'https://www.thenews.com.pk/rss/1/2': 'The News International',
    'https://tribune.com.pk/feed/latest': 'Express Tribune',
    'https://www.dawn.com/feed': 'Dawn',
    'https://www.pakistantoday.com.pk/category/national/feed/': 'Pakistan Today',
    'https://www.brecorder.com/feeds/latest-news/': 'Business Recorder',
    'https://www.sundayguardianlive.com/feed': 'Sunday Guardian',
    'https://www.mashriqtv.pk/feed/': 'Mashriq TV',
    'https://www.geo.tv/rss/1/53': 'Geo News',
    'https://www.bolnews.com/feed/': 'Bol News',
    'http://feeds.bbci.co.uk/news/rss.xml': 'BBC News',
  };

  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    List<Article> fetchedArticles = [];

    for (String url in rssSources.keys) {
      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          var document = xml.XmlDocument.parse(response.body);
          var items = document.findAllElements('item');
          for (var item in items) {
            String title = item.findElements('title').single.text;
            String link = item.findElements('link').single.text;
            String description = item.findElements('description').single.text;

            fetchedArticles.add(Article(
              title: title,
              link: link,
              description: description,
              source: rssSources[url] ?? "Unknown Source",
            ));
          }
        }
      } catch (e) {
        print("Error fetching news from $url: $e");
      }
    }

    setState(() {
      articles = fetchedArticles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: articles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ArticleWidget(article: articles[index]);
        },
      ),
    );
  }
}

class ArticleWidget extends StatelessWidget {
  final Article article;

  ArticleWidget({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              article.description,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'Source: ${article.source}',
              style: TextStyle(fontSize: 12, color: Colors.grey[400]),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                _launchURL(article.link);
              },
              child: Text(
                'Read More...',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    // You can use url_launcher package for opening the URL in a browser
    final Uri _url = Uri.parse(url);
    await http.get(_url);
  }
}

class Article {
  final String title;
  final String link;
  final String description;
  final String source;

  Article({
    required this.title,
    required this.link,
    required this.description,
    required this.source,
  });
}
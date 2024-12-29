import 'package:flutter/material.dart';
import 'Article_Categ.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:lottie/lottie.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_tts/flutter_tts.dart';


class CategPolitics extends StatefulWidget {
  const CategPolitics({Key? key}) : super(key: key);

  @override
  _CategPoliticsState createState() => _CategPoliticsState();
}

class _CategPoliticsState extends State<CategPolitics> {
  List<Map<String, String>> _geoNewsItems = [];
  List<Map<String, String>> _aSportsNewsItems = [];
  List<Map<String, String>> _dawnNewsItems = [];
  List<Map<String, String>> _AlmashriqnewsItems = [];
  List<Map<String, String>> _AajTvNewsItems = [];
  List<Map<String, String>> _AbtakkNewsItems = [];
  List<Map<String, String>> _PakistanTodayNewsItems = [];
  List<Map<String, String>> _ExpressTribuneNewsItems = [];
  List<Map<String, String>> _BolNewsItems = [];
  List<Map<String, String>> _HumNewsItems = [];
  List<Map<String, String>> _GnnNewsItems = [];
  List<Map<String, String>> _bbcNewsItems=[];
  List<Map<String, String>> _nyNewsItems=[];
  List<Map<String, String>> _googleNewsItems=[];






  bool _isLoadingGeo = true;
  bool _isLoadingASports = true;
  bool _isLoadingDawnNews = true;
  bool _isLoadingAlmashriqNews = true;
  bool _isLoadingAajtvNews = true;
  bool _isLoadingAbtakkNews = true;
  bool _isLoadingPakistanTodayNews = true;
  bool _isLoadingExpressTribune = true;
  bool _isLoadingBol = true;
  bool _isLoadingHum = true;
  bool _isLoadinggnn = true;
  bool _isLoadingbbc = true;
  bool _isLoadingny = true;
  bool _isLoadinggoogle = true;








  @override
  void initState() {
    super.initState();
    _fetchGeoNews();
    _fetchASportsNews();
    _fetchDawnNews();
    _fetchAlmashriqNews();
    _fetchAajTvNews();
    _fetchAbtakkNews();
    _fetchPakistanTodayNews();
    _fetchExpressTribuneNews();
    _fetchBolNews();
    _fetchHumNews();
    _fetchbbcNews();
    _fetchGoogleNews();
    _fetchnyNews();
    _fetchGnnNews();
  }

  Future<void> _fetchGeoNews() async {
    await _fetchNews(
      'https://www.geo.tv/rss/1/1',
          (news) => setState(() {
        _geoNewsItems = news;
        _isLoadingGeo = false;
      }),
    );
  }

  Future<void> _fetchASportsNews() async {
    await _fetchNews(
      'https://arynews.tv/category/pakistan/feed/',
          (news) => setState(() {
        _aSportsNewsItems = news;
        _isLoadingASports = false;
      }),
    );
  }

  Future<void> _fetchDawnNews() async {
    await _fetchNews(
      'https://www.dawn.com/feeds/pakistan/',
          (news) => setState(() {
        _dawnNewsItems = news;
        _isLoadingDawnNews = false;
      }),
    );
  }

  Future<void> _fetchAlmashriqNews() async {
    await _fetchNews(
      'https://mashriqtv.pk/category/pakistan-news/feed/',
          (news) => setState(() {
        _AlmashriqnewsItems = news;
        _isLoadingAlmashriqNews = false;
      }),
    );
  }
  Future<void> _fetchGnnNews() async {
    await _fetchNews(
      'https://gnnhd.tv/rss/pakistan',
          (news) => setState(() {
        _GnnNewsItems= news;
        _isLoadinggnn = false;
      }),
    );
  }
  Future<void> _fetchbbcNews() async {
    await _fetchNews(
      'https://gnnhd.tv/rss/sports',
          (news) => setState(() {
        _bbcNewsItems= news;
        _isLoadingbbc = false;
      }),
    );
  }
  Future<void> _fetchnyNews() async {
    await _fetchNews(
      'https://www.nytimes.com/athletic/rss/news/',
          (news) => setState(() {
        _nyNewsItems= news;
        _isLoadingny = false;
      }),
    );
  }
  Future<void> _fetchAajTvNews() async {
    await _fetchNews(
      'https://www.aaj.tv/feeds/pakistan/',
          (news) => setState(() {
        _AajTvNewsItems = news;
        _isLoadingAajtvNews = false;
      }),
    );
  }

  Future<void> _fetchAbtakkNews() async {
    await _fetchNews(
      'https://abbtakk.tv/feed/',
          (news) => setState(() {
        _AbtakkNewsItems = news;
        _isLoadingAbtakkNews = false;
      }),
    );
  }

  Future<void> _fetchPakistanTodayNews() async {
    await _fetchNews(
      'https://www.pakistantoday.com.pk/category/national/feed/',
          (news) => setState(() {
        _PakistanTodayNewsItems = news;
        _isLoadingPakistanTodayNews = false;
      }),
    );
  }

  Future<void> _fetchGoogleNews() async {
    await _fetchNews(
      'https://news.google.com/rss/topics/CAAqJQgKIh9DQkFTRVFvSUwyMHZNRFZ6WWpFU0JXVnVMVWRDS0FBUAE?hl=en-PK&gl=PK&ceid=PK%3Aen&oc=11',
          (news) => setState(() {
        _googleNewsItems = news;
        _isLoadinggoogle = false;
      }),
    );
  }

  Future<void> _fetchExpressTribuneNews() async {
    try {
      List<Map<String, String>> combinedNews = [];

      // First Link
      await _fetchNews(
        'https://tribune.com.pk/feed/politics',
            (news) {
          combinedNews.addAll(news);
        },
      );



      setState(() {
        _ExpressTribuneNewsItems = combinedNews; // ✅ Correct list updated
        _isLoadingExpressTribune = false;
      });
    } catch (e) {
      print('Error fetching Express Tribune news: $e');
      setState(() {
        _isLoadingExpressTribune = false;
      });
    }
  }

  Future<void> _fetchBolNews() async {
    try {
      List<Map<String, String>> combinedNews = [];

      // First Link
      await _fetchNews(
        'https://www.bolnews.com/politics/feed/',
            (news) {
          combinedNews.addAll(news);
        },
      );

      // Second Link
      await _fetchNews(
        'https://www.bolnews.com/politics/feed/?paged=2',
            (news) {
          combinedNews.addAll(news);
        },
      );
      await _fetchNews(
        'https://www.bolnews.com/politics/feed/?paged=3',
            (news) {
          combinedNews.addAll(news);
        },
      );

      setState(() {
        _BolNewsItems = combinedNews; // ✅ Correct list updated
        _isLoadingBol = false;

      });
    } catch (e) {
      print('Error fetching Bol news: $e');
      setState(() {
        _isLoadingBol = false;
      });
    }
  }

  Future<void> _fetchHumNews() async {
    try {
      List<Map<String, String>> combinedNews = [];

      // First Link
      await _fetchNews(
        'https://humnews.pk/pakistan/feed/',
            (news) {
          combinedNews.addAll(news);
        },
      );

      // Second Link
      await _fetchNews(
        'https://humnews.pk/pakistan/feed/?paged=2',
            (news) {
          combinedNews.addAll(news);
        },
      );
      await _fetchNews(
        'https://humnews.pk/pakistan/feed/?paged=3',
            (news) {
          combinedNews.addAll(news);
        },
      );

      setState(() {
        _HumNewsItems = combinedNews; // ✅ Correct list updated
        _isLoadingHum = false;
      });
    } catch (e) {
      print('Error fetching Hum news: $e');
      setState(() {
        _isLoadingHum = false;
      });
    }
  }



  String stripHtmlTags(String htmlString) {
    final document = html_parser.parse(htmlString);
    final String parsedString = document.body?.text ?? '';
    return parsedString;
  }

  Future<void> _fetchNews(String url, Function(List<Map<String, String>>) onComplete) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final document = xml.XmlDocument.parse(response.body);
        final items = document.findAllElements('item');

        List<Map<String, String>> news = items.map((item) {
          final title = item.findElements('title').isNotEmpty ? item.findElements('title').first.text : 'No title';
          final link = item.findElements('link').isNotEmpty ? item.findElements('link').first.text : '';
          final description = item.findElements('description').isNotEmpty ? item.findElements('description').first.text : 'No description';

          // Check for media:content or enclosure tags
          String imageUrl = '';
          final mediaContent = item.findElements('media:content').firstOrNull?.getAttribute('url');
          final enclosure = item.findElements('enclosure').firstOrNull?.getAttribute('url');

          if (mediaContent != null && mediaContent.isNotEmpty) {
            imageUrl = mediaContent;
          } else if (enclosure != null && enclosure.isNotEmpty) {
            imageUrl = enclosure;
          } else {
            imageUrl = parseHtmlString(description);
          }

          return {
            'title': title,
            'link': link,
            'description': stripHtmlTags(description).split('\n').take(2).join(' '),
            'imageUrl': imageUrl,
          };
        }).toList();

        onComplete(news);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }


  String parseHtmlString(String htmlString) {
    final document = html_parser.parse(htmlString);
    final imageElement = document.querySelector('img');
    String? imageUrl;

    if (imageElement != null) {
      imageUrl = imageElement.attributes['src'];
    } else {
      final ogImageMeta = document.querySelector('meta[property="og:image"]');
      if (ogImageMeta != null) {
        imageUrl = ogImageMeta.attributes['content'];
      }
    }

    return imageUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Politics'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCollapsibleSection('Geo News', _geoNewsItems, _isLoadingGeo),
            SizedBox(height: 20),
            _buildCollapsibleSection('ARY News', _aSportsNewsItems, _isLoadingASports),
            SizedBox(height: 20),
            _buildCollapsibleSection('Dawn', _dawnNewsItems, _isLoadingDawnNews),
            SizedBox(height: 20),
            _buildCollapsibleSection('Aaj Tv', _AajTvNewsItems, _isLoadingAajtvNews),
            SizedBox(height: 20),
            _buildCollapsibleSection('Express Tribune ', _ExpressTribuneNewsItems, _isLoadingExpressTribune),
            SizedBox(height: 20),
            _buildCollapsibleSection('Abb takk', _AbtakkNewsItems, _isLoadingAbtakkNews),
            SizedBox(height: 20),
            _buildCollapsibleSection('Pakistan Today', _PakistanTodayNewsItems, _isLoadingPakistanTodayNews),
            SizedBox(height: 20),
            _buildCollapsibleSection('Al Mashriq News', _AlmashriqnewsItems, _isLoadingAlmashriqNews),
            SizedBox(height: 20),
            _buildCollapsibleSection('Express Tribune ', _ExpressTribuneNewsItems, _isLoadingExpressTribune),
            SizedBox(height: 20),
            _buildCollapsibleSection('Bol News ', _BolNewsItems, _isLoadingBol),
            SizedBox(height: 20),
            _buildCollapsibleSection('Hum News ', _HumNewsItems, _isLoadingHum),
            SizedBox(height: 20),
            _buildCollapsibleSection('GNN ', _GnnNewsItems, _isLoadinggnn),

            SizedBox(height: 20),
            _buildCollapsibleSection('Google News', _googleNewsItems, _isLoadinggoogle),
          ],
        ),
      ),
    );
  }


  Widget _buildCollapsibleSection(String title, List<Map<String, String>> newsItems, bool isLoading) {
    // A list to store the comments and reactions for each news item
    List<String> comments = List.generate(newsItems.length, (index) => '');
    List<int> reactions = List.generate(newsItems.length, (index) => 0); // 0 = Neutral, 1 = Like, -1 = Dislike

    // Initialize Flutter TTS
    FlutterTts flutterTts = FlutterTts();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 2,
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          children: [
            isLoading
                ? Center(
              child: Lottie.asset('assets/animations/loading.json', width: 100, height: 100),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Prevent internal scrolling
              itemCount: newsItems.length,
              itemBuilder: (context, index) {
                final news = newsItems[index];

                return Column(
                  children: [
                    _buildNewsCard(news),

                    // Reaction Buttons: Like, Dislike, Neutral
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.thumb_up,
                            color: reactions[index] == 1 ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              reactions[index] = 1; // Like
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.thumb_down,
                            color: reactions[index] == -1 ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              reactions[index] = -1; // Dislike
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.thumb_up_off_alt,
                            color: reactions[index] == 0 ? Colors.grey : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              reactions[index] = 0; // Neutral
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.volume_up, color: Colors.orange),
                          onPressed: () async {
                            // Ensure the article text exists, and read it aloud
                            String articleText = news['articleText'] ?? 'Article content is unavailable.';
                            await flutterTts.speak(articleText);
                          },
                        ),
                      ],
                    ),

                    // Comment Box Section
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (text) {
                          // Update the comment for the respective news item
                          comments[index] = text;
                        },
                        decoration: InputDecoration(
                          labelText: 'Add a comment...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // When the user clicks submit, display the comment below
                        setState(() {
                          comments[index] = comments[index]; // Trigger rebuild to display the comment
                        });
                      },
                      child: Text('Submit'),
                    ),
                    if (comments[index].isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Comment: ${comments[index]}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(Map<String, String> news) {
    return Card(
      child: ListTile(
        leading: news['imageUrl']!.isNotEmpty ? Image.network(news['imageUrl']!) : null,
        title: Text(news['title']!),
        subtitle: Text(news['description']!, maxLines: 2, overflow: TextOverflow.ellipsis),
        onTap: () => _launchURL(news['link']!, news['title']!),
      ),
    );
  }

  void _launchURL(String url, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ArticleCategScreen(articleUrl: url, title: title)),
    );
  }
}
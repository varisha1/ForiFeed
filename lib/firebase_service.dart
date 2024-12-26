import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

import 'package:html/parser.dart' as html;

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Saves a list of followed channels for the current user.
  Future<void> saveFollowedChannels(List<String> channels) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set(
        {
          'followedChannels': channels,
        },
        SetOptions(merge: true), // Merges with existing data
      );
    } else {
      throw Exception("No user is logged in");
    }
  }

  /// Fetches the followed channels for the current user.
  Future<List<String>> fetchFollowedChannels() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(user.uid).get();
      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return List<String>.from(data['followedChannels'] ?? []);
      }
    }
    return [];
  }

  /// Fetches the names of all available news channels.
  Future<List<String>> fetchAvailableNewsChannels() async {
    // This should be replaced with your actual collection and field for channel names
    QuerySnapshot snapshot = await _firestore.collection('news_channels').get();
    List<String> channelNames = [];
    for (var doc in snapshot.docs) {
      // Assuming 'name' field holds the name of the news channel
      channelNames.add(doc['name']);
    }
    return channelNames;
  }

  /// Logs the user in with email and password.
  Future<User?> signInWithEmail(String email, String password) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  /// Logs the user out.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Saves a tapped article's title, URL, and content for the current user.
  Future<void> saveTappedArticle(String articleTitle, String articleUrl) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Fetch the article content before saving the article
      String articleContent = await _fetchArticleContent(articleUrl);

      // Save the tapped article under the user's 'tappedArticles' sub-collection
      await _firestore.collection('users').doc(user.uid).collection('tappedArticles').add(
        {
          'title': articleTitle,
          'url': articleUrl,
          'content': articleContent,  // Save the full content here
          'timestamp': FieldValue.serverTimestamp(),
        },
      );
    } else {
      throw Exception("No user is logged in");
    }
  }

  Future<void> saveSentiment(String sentiment, String articleTitle, String articleUrl) async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        // Reference to the sentiment collection
        final sentimentCollection = _firestore
            .collection('users')
            .doc(user.uid)
            .collection('sentiment');

        // Check if there's already a record for the article
        final querySnapshot = await sentimentCollection
            .where('articleTitle', isEqualTo: articleTitle)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // If an entry exists, update it
          final docId = querySnapshot.docs.first.id;
          await sentimentCollection.doc(docId).set({
            'articleTitle': articleTitle,
            'articleUrl': articleUrl,
            'sentiment': sentiment,
            'timestamp': FieldValue.serverTimestamp(),
          });
          print("Sentiment updated for article: $articleTitle");
        } else {
          // If no entry exists, create a new one
          await sentimentCollection.add({
            'articleTitle': articleTitle,
            'articleUrl': articleUrl,
            'sentiment': sentiment,
            'timestamp': FieldValue.serverTimestamp(),
          });
          print("New sentiment saved for article: $articleTitle");
        }
      } catch (e) {
        print("Error saving sentiment: $e");
      }
    } else {
      print("Error: No user is logged in");
    }
  }





  /// Fetches the tapped articles for the current user.
  Future<List<Map<String, dynamic>>> fetchTappedArticles() async {
    User? user = _auth.currentUser;
    List<Map<String, dynamic>> tappedArticles = [];

    if (user != null) {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('tappedArticles')
          .get();

      for (var doc in snapshot.docs) {
        tappedArticles.add(doc.data() as Map<String, dynamic>);
      }
    }
    return tappedArticles;
  }

  /// Helper method to fetch the article content from the article URL
  Future<String> _fetchArticleContent(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parse the HTML content of the article page
        final document = html_parser.parse(response.body);

        // Extract the article content using selectors (adjust based on website structure)
        final articleElement = document.querySelector('article') ?? document.body;

        if (articleElement != null) {
          // Remove any unwanted tags like <script>, <style>, etc.
          articleElement.querySelectorAll('script, style, noscript').forEach((element) => element.remove());

          // Get the cleaned text content
          String articleContent = articleElement.text;

          // Replace multiple spaces or newlines with a single space
          articleContent = articleContent.replaceAll(RegExp(r'\s+'), ' ').trim();

          return articleContent;
        } else {
          return 'No article content found';
        }
      } else {
        throw Exception("Failed to load article content (Status Code: ${response.statusCode})");
      }
    } catch (e) {
      print('Error fetching article content: $e');
      return 'Error fetching article content';
    }
  }


  Future<List<Map<String, dynamic>>> fetchAvailableArticles() async {
    List<Map<String, dynamic>> availableArticles = [];

    // You should replace this with your actual collection to fetch all articles
    QuerySnapshot snapshot = await _firestore.collection('news_articles').get();

    for (var doc in snapshot.docs) {
      availableArticles.add(doc.data() as Map<String, dynamic>);
    }

    return availableArticles;
  }


  Future<List<Map<String, dynamic>>> fetchArticles() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await firestore.collection('news').get();

    // Map the data from Firestore into a list of articles
    List<Map<String, dynamic>> articles = snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        'title': doc['title'],
        'content': doc['content'],
        'link': doc['link'],
      };
    }).toList();

    return articles;
  }
  /// Content-based filtering method for recommendations
  Future<List<Map<String, dynamic>>> getRecommendedArticles() async {
    User? user = _auth.currentUser;
    List<Map<String, dynamic>> recommendedArticles = [];

    if (user != null) {
      List<Map<String, dynamic>> tappedArticles = await fetchTappedArticles();

      // If there are no tapped articles, no recommendations
      if (tappedArticles.isEmpty) return recommendedArticles;

      // Extract keywords from tapped articles
      List<String> tappedArticleContents = tappedArticles.map((article) => article['content'].toString()).toList();

      // Now, loop through all articles in Firestore and compare them with the tapped articles
      QuerySnapshot allArticlesSnapshot = await _firestore.collection('users').doc(user.uid).collection('tappedArticles').get();

      for (var doc in allArticlesSnapshot.docs) {
        String articleContent = doc['content'];
        String articleTitle = doc['title'];
        String articleUrl = doc['url'];

        // Compare the current article content with the tapped articles' content
        for (var tappedArticleContent in tappedArticleContents) {
          if (_contentSimilarity(tappedArticleContent, articleContent)) {
            // If there is a match, add it to recommendations
            recommendedArticles.add({
              'title': articleTitle,
              'url': articleUrl,
              'content': articleContent,
            });
            break; // Found a match, break inner loop
          }
        }
      }
    }
    return recommendedArticles;
  }

  /// Basic similarity check (matching keywords)
  bool _contentSimilarity(String content1, String content2) {
    List<String> content1Words = content1.split(' ');
    List<String> content2Words = content2.split(' ');

    int matchCount = 0;

    for (var word in content1Words) {
      if (content2Words.contains(word)) {
        matchCount++;
      }
    }

    // Consider it a match if at least 20% of words match (adjust as needed)
    return matchCount / content1Words.length >= 0.2;
  }
}




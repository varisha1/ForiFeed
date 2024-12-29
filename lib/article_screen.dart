import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class ArticleScreen extends StatefulWidget {
  final String articleUrl;

  const ArticleScreen({required this.articleUrl});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final FlutterTts flutterTts = FlutterTts();
  late WebViewController _webViewController;
  bool isLoading = true;
  bool isSpeaking = false; // Track whether the TTS is speaking

  @override
  void initState() {
    super.initState();
    _setupTts();
    // Initialize WebView
    _initializeWebView();
  }

  void _initializeWebView() {
    // Initialize WebView
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
    // Use loadRequest() instead of loadUrl() in version 4.x
      ..loadRequest(Uri.parse(widget.articleUrl));
  }

  Future<void> _setupTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> _speak() async {
    String articleContent = await _getArticleContent();

    if (articleContent.isNotEmpty) {
      if (isSpeaking) {
        // Stop the TTS if it's already speaking
        await flutterTts.stop();
        setState(() {
          isSpeaking = false;
        });
      } else {
        // Start speaking the entire content at once
        print("Speaking content: $articleContent");
        await flutterTts.speak(articleContent);
        setState(() {
          isSpeaking = true;
        });
      }
    } else {
      print("No article content found!");
    }
  }

  Future<String> _getArticleContent() async {
    try {
      // Run JavaScript to get clean article content (only text from paragraphs, headings, etc.)
      final result = await _webViewController.runJavaScriptReturningResult("""
      (function() {
        var articleContent = '';
        var titleElement = document.querySelector('h1');
        if (titleElement) {
          articleContent += titleElement.innerText + ' ';
        }
        
        // Extract content from paragraphs, headings, and sections
        var paragraphs = document.querySelectorAll('p, h2, h3, h4, h5, h6, section');
        paragraphs.forEach(function(element) {
          articleContent += element.innerText + ' ';
        });
        
        return JSON.stringify(articleContent.trim());
      })();
    """);

      // Decode the result and cast to String
      String content = jsonDecode(result.toString());

      print("Extracted Article Content: $content");

      return content.trim();
    } catch (e) {
      print("Error extracting content: $e");
      return '';
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(isSpeaking ? Icons.stop : Icons.volume_up), // Toggle icon based on speaking status
            onPressed: _speak,
          ),
        ],
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}

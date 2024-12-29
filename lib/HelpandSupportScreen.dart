import 'package:flutter/material.dart';
import 'dart:ui'; // Required for BackdropFilter
import 'package:lottie/lottie.dart'; // Import Lottie package

class HelpAndSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A90E2), // Light Blue
              Color(0xFFB0C6E3), // Very Light Blue
              Color(0xFF3686AC), // Light Grey
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Text(
                              'Help & Support',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Lottie Animation and Text Side by Side
                        Row(
                          children: [
                            // Lottie Animation on Left
                            Container(
                              width: 100, // You can adjust the size of the animation here
                              height: 100,
                              child: Lottie.asset('assets/animations/i.json'), // Replace with your animation asset path
                            ),

                            // Text on Right
                            Expanded(
                              child: Text(
                                'Need help? Choose a section below to get assistance with your issue.',
                                style: TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Help Sections
                        _buildHelpSection(
                          context,
                          title: 'Account Issues',
                          content: '''Having trouble logging in or resetting your password? 
Here are a few steps you can follow to resolve the issue:
1. Ensure you’re entering the correct email and password.
2. Use the 'Forgot Password' option to reset your password.
3. Check your internet connection and try logging in again.''',
                        ),
                        SizedBox(height: 20),

                        _buildHelpSection(
                          context,
                          title: 'App Usage',
                          content: '''Learn how to navigate the app and use its features:
1. Use the bottom navigation bar to switch between sections.
2. Tap on an article to read the full details.
3. Customize settings under the Profile section.''',
                        ),
                        SizedBox(height: 20),

                        _buildHelpSection(
                          context,
                          title: 'Technical Issues',
                          content: '''Experiencing crashes or slow performance? 
Try these steps:
1. Close and reopen the app to reset it.
2. Ensure your device is up to date with the latest software.
3. Clear the app cache through your device settings.''',
                        ),
                        SizedBox(height: 20),

                        _buildHelpSection(
                          context,
                          title: 'Payment Issues',
                          content: '''Facing problems with payments or transactions? 
Here’s what you can do:
1. Verify that your payment method is valid.
2. Check if there are any connectivity issues preventing the transaction.
3. Contact customer support if the issue persists.''',
                        ),
                        SizedBox(height: 40),
                        // New Help Sections
                        _buildHelpSection(
                          context,
                          title: 'Notification Settings',
                          content: '''Manage your notifications easily:
1. Go to Settings > Notifications.
2. Enable or disable alerts as per your preference.
3. Ensure your device settings allow app notifications.''',
                        ),
                        SizedBox(height: 20),

                        _buildHelpSection(
                          context,
                          title: 'Privacy Policy',
                          content: '''Your privacy matters to us:
1. View our Privacy Policy under Settings > Privacy.
2. Understand how your data is stored and used.
3. Contact support for further clarifications.''',
                        ),
                        SizedBox(height: 20),

                        _buildHelpSection(
                          context,
                          title: 'Language Settings',
                          content: '''Change your app language:
1. Navigate to Settings > Language.
2. Select your preferred language from the list.
3. Restart the app if changes don’t apply immediately.''',
                        ),
                        SizedBox(height: 20),

                        _buildHelpSection(
                          context,
                          title: 'Report Bugs',
                          content: '''Help us improve by reporting bugs:
1. Go to Settings > Report a Problem.
2. Provide a detailed description of the issue.
3. Attach screenshots if possible.''',
                        ),
                        SizedBox(height: 20),

                        _buildHelpSection(
                          context,
                          title: 'Contact Support',
                          content: '''Need direct assistance? 
1. Email us at varishaalee3271@gmail.com.
2. Call our 24/7 support line at +92 3312112298.
3. Use the in-app chat feature for quick queries.''',
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHelpSection(BuildContext context,
      {required String title, required String content}) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          barrierColor: Colors.black.withOpacity(0.4),
          builder: (context) {
            return Center(
              child: SingleChildScrollView(
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF4A90E2),
                            Color(0xFF3686AC),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            content,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HelpAndSupportScreen(),
  ));
}

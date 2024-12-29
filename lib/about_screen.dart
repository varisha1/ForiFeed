import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: GoogleFonts.dmSans(fontSize: 20),
        ),
        backgroundColor: Color(0xFF0D1B2A), // Dark Blue for AppBar
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0D1B2A), // Dark Blue
              Color(0xFF1B263B), // Deep Blue
              Color(0xFF000000), // Black
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fori Feed',
              style: GoogleFonts.dmSans(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Version: 1.0.0',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'This News App provides the latest updates from various categories, including Sports, Entertainment, Politics, Pakistan, and Business. Stay informed with real-time news updates fetched via RSS and web scraping technologies.',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Developed by:',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Team Fori Feed',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 30),
            Divider(color: Colors.white38),
            SizedBox(height: 10),
            Text(
              'Contact Us:',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Email: varishaalee3271@gmail.com\nPhone: +92 331 2112298',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                '© 2024 News App. All rights reserved.',
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

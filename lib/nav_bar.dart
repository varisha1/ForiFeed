import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:forif/News_screen2.dart';
import 'package:forif/about_screen.dart';
import 'package:forif/categ_business.dart';
import 'package:forif/categ_entertainment.dart';
import 'package:forif/categ_pakistan.dart';
import 'package:forif/categ_politics.dart';
import 'package:forif/login_screen.dart';
import 'categ_sports.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class NavBar extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser; // Get the current Firebase user

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF30557C), // Background gradient
              Color(0xFF1A2C4E),
              Color(0xFF421747)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Custom Drawer Header with Profile Picture and Username
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, bottom: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!) // Use Firebase user's profile picture
                        : AssetImage('assets/profile.jpg') as ImageProvider, // Fallback to local image
                  ),
                  SizedBox(height: 10),
                  Text(
                    user?.email ?? 'Guest', // Show email if available, otherwise 'Guest'
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // List Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildListTile(context, Icons.sports_soccer, 'Sports', CategSports()),
                  _buildListTile(context, Icons.movie_creation, 'Entertainment', CategEntertainment()),
                  _buildListTile(context, Icons.gavel, 'Politics', CategPolitics()),
                  _buildListTile(context, Icons.flag, 'Pakistan', CategPakistan()),
                  _buildListTile(context, Icons.business_center, 'Business', CategBusiness()),
                  _buildListTile(context, Icons.fiber_new, 'Latest', NewsScreen2()),
                  Divider(color: Colors.white70),
                  _buildColoredListTile(context, Icons.settings, 'Settings', Colors.blueGrey),
                  _buildColoredListTile(
                    context,
                    Icons.info_outline,
                    'About',
                    Colors.teal,
                        () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutScreen()),
                      );
                    },
                  ),

                  _buildColoredListTile(
                    context,
                    Icons.logout,
                    'Logout',
                    Colors.redAccent,
                        () async {
                      try {
                        await FirebaseAuth.instance.signOut(); // Sign out from Firebase
                        Navigator.pop(context); // Close the drawer
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        ); // Navigate directly to login screen
                      } catch (e) {
                        print('Error during logout: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to log out. Please try again.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),


                ],
              ),
            ),
            // Footer Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Version 1.0.0',
                  style: GoogleFonts.dmSans( // Apply DM Sans font
                    color: Colors.grey[200],
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(BuildContext context, IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: GoogleFonts.dmSans(color: Colors.white), // Apply DM Sans font
      ),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }

  ListTile _buildColoredListTile(BuildContext context, IconData icon, String title, Color color, [VoidCallback? onTap]) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: GoogleFonts.dmSans(color: color), // Apply DM Sans font with color
      ),
      onTap: onTap ?? () => Navigator.pop(context), // Close the drawer or execute custom action
    );
  }
}

class MyDrawerController extends StatefulWidget {
  @override
  _MyDrawerControllerState createState() => _MyDrawerControllerState();
}

class _MyDrawerControllerState extends State<MyDrawerController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('News App', style: GoogleFonts.dmSans()), // Apply DM Sans font
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to News App!',
          style: GoogleFonts.dmSans(fontSize: 24), // Apply DM Sans font
        ),
      ),
    );
  }
}

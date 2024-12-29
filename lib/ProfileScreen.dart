import 'package:flutter/material.dart';
import 'package:forif/HelpandSupportScreen.dart';
import 'package:forif/Settings_Screen.dart';
import 'package:forif/feedback_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'News_screen2.dart';
import 'EditProfileScreen.dart';
import 'Privacy_screen.dart'; // Ensure this screen exists
import 'package:firebase_auth/firebase_auth.dart';  // Add Firebase Auth import
import 'package:firebase_core/firebase_core.dart';  // Add Firebase Core import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2B90B8), // Dark Blue
              Color(0xFF2B2D42), // Greyish Blue
              Color(0xFF6A0572), // Purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  Icon(Icons.settings, color: Colors.white),
                  SizedBox(width: 16),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    SizedBox(height: 16),
                    FutureBuilder<User?>(
                      // Fetch current user from Firebase
                      future: _getCurrentUser(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (!snapshot.hasData) {
                          return Text('No user logged in');
                        }

                        // Extract user information from Firebase
                        User? user = snapshot.data;
                        return Column(
                          children: [
                            Text(
                              user!.displayName ?? "",
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.email ?? "No email provided",
                              style: GoogleFonts.dmSans(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen()),
                        );
                      },
                      child: Text(
                        "Edit Profile",
                        style: GoogleFonts.dmSans(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Upgrade to PRO",
                        style: GoogleFonts.dmSans(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey[700]),
              _buildCurvedTile(Icons.privacy_tip, "Privacy", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyScreen()),
                );
              }),
              _buildCurvedTile(Icons.history, "User Feedback / Reviews", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackScreen() ),
                );

              }),
              _buildCurvedTile(Icons.help_outline, "Help & Support", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpAndSupportScreen()),
                );
                // Navigate to Help & Support
              }),
              _buildCurvedTile(Icons.settings, "Settings", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              }),
              _buildCurvedTile(Icons.group_add, "Invite a Friend", () {
                // Invite functionality
              }),
              Divider(color: Colors.grey[700]),
              _buildCurvedTile(Icons.logout, "Logout", () {
                _showLogoutConfirmation(context);
              }, isLogout: true),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1A1A40),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue,
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsScreen2()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Grocery"),
          BottomNavigationBarItem(icon: Icon(Icons.wifi_off), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account"),
        ],
      ),
    );
  }

  Future<User?> _getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    return user;
  }

  Widget _buildCurvedTile(IconData icon, String title, VoidCallback onTap,
      {bool isLogout = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(24),
        ),
        child: ListTile(
          leading: Icon(icon, color: isLogout ? Colors.red : Colors.white),
          title: Text(
            title,
            style: GoogleFonts.dmSans(
              color: isLogout ? Colors.red : Colors.white,
              fontSize: 16,
            ),
          ),
          trailing: Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Logout",
          style: GoogleFonts.dmSans(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Are you sure you want to logout?",
          style: GoogleFonts.dmSans(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text("Cancel", style: GoogleFonts.dmSans()),
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();  // Log the user out
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to login or home screen
            },
            child: Text(
              "Logout",
              style: GoogleFonts.dmSans(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

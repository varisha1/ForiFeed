import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  String _errorMessage = '';
  bool _isPasswordChanging = false;

  // Function to change the password
  Future<void> _changePassword() async {
    setState(() {
      _isPasswordChanging = true; // Show loading indicator
      _errorMessage = ''; // Clear previous error message
    });

    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Re-authenticate the user
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _currentPasswordController.text,
        );

        await user.reauthenticateWithCredential(credential);

        // Change password
        await user.updatePassword(_newPasswordController.text);
        setState(() {
          _errorMessage = 'Password updated successfully!';
        });

        // Show success popup
        _showSuccessPopup();
      } else {
        setState(() {
          _errorMessage = 'No user is signed in.';
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred';
      });
    } finally {
      setState(() {
        _isPasswordChanging = false; // Hide loading indicator
      });
    }
  }

  // Function to show success popup after password change
  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          title: Text(
            'Password Changed',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Your password has been changed successfully. Your session has expired. Please log in with your new password.',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            // Login button
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to delete the user account
  Future<void> _deleteAccount() async {
    setState(() {
      _isPasswordChanging = true;
    });
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Re-authenticate the user before deleting the account
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _currentPasswordController.text,
        );

        // Reauthenticate with the credential
        await user.reauthenticateWithCredential(credential);

        // Delete the account
        await user.delete();
        setState(() {
          _errorMessage = 'Account deleted successfully!';
        });

        // Show success popup
        _showDeleteAccountPopup();
      } else {
        setState(() {
          _errorMessage = 'No user is signed in.';
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred';
      });
    } finally {
      setState(() {
        _isPasswordChanging = false;
      });
    }
  }

  // Function to show delete account confirmation popup
  void _showDeleteAccountPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          title: Text(
            'Account Deleted',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Your account has been deleted successfully.',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            // Login button (after account deletion)
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to display the password change form within the same screen
  void _showPasswordChangeForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          title: Text(
            'Change Password',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Current password input field
              TextField(
                controller: _currentPasswordController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  labelStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey.shade700,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // New password input field
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey.shade700,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.blueAccent)),
            ),
            // Submit button
            TextButton(
              onPressed: _isPasswordChanging
                  ? null // Disable button if password is changing
                  : () {
                Navigator.pop(context);
                _changePassword(); // Change password
              },
              child: _isPasswordChanging
                  ? CircularProgressIndicator()
                  : Text('Change Password', style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade600, Colors.grey.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Settings and other options
              ListTile(
                title: Text(
                  'Profile Settings',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Add navigation or functionality for profile settings if needed
                },
              ),
              Divider(color: Colors.white),

              // Change Password Section
              ListTile(
                title: Text(
                  'Change Password',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  _showPasswordChangeForm(); // Show password change form in the same screen
                },
              ),

              // Delete Account Section
              ListTile(
                title: Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Show confirmation dialog for account deletion
                  _showDeleteConfirmationDialog();
                },
              ),

              if (_errorMessage.isNotEmpty) ...[
                SizedBox(height: 20),
                Text(
                  _errorMessage,
                  style: TextStyle(
                    color: _errorMessage.contains('successfully')
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Function to show delete account confirmation dialog
  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          title: Text(
            'Confirm Account Deletion',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.blueAccent)),
            ),
            // Confirm button
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                _deleteAccount(); // Proceed to delete the account
              },
              child: Text('Delete Account', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SettingsScreen(),
  ));
}

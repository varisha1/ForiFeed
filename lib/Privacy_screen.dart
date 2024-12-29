import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class PrivacyScreen extends StatefulWidget {
  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  String deviceName = 'Unknown Device';
  String loginTime = '';
  String loginDate = '';

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
    getCurrentDateTime();
  }

  Future<void> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      setState(() {
        deviceName = androidInfo.model; // Android device name
      });
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      setState(() {
        deviceName = iosInfo.name; // iOS device name
      });
    }
  }

  void getCurrentDateTime() {
    final now = DateTime.now();
    setState(() {
      loginTime = "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
      loginDate = "${now.day}/${now.month}/${now.year}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Privacy Settings",
          style: GoogleFonts.dmSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
            SizedBox(height: 16),
            Text(
              "You're Logged In",
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 14), // Green Dot
                SizedBox(width: 8),
                Text(
                  deviceName,
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Login Time: $loginTime",
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: Colors.white60,
              ),
            ),
            Text(
              "Login Date: $loginDate",
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: Colors.white60,
              ),
            ),
            SizedBox(height: 24),
            Divider(color: Colors.white30),
            SizedBox(height: 24),
            Text(
              "Your Privacy is Our Priority",
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "We ensure that your personal data is securely stored and your "
                  "privacy is respected at every step. All your activities are "
                  "encrypted and protected with the latest security protocols.",
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Add functionality if needed
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Manage Privacy Settings",
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

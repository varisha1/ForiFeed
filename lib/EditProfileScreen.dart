import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;  // To store the picked image

  // Create an instance of ImagePicker
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from gallery
  Future<void> _pickImageFromCamera() async {
    // Request permission for the camera
    PermissionStatus status = await Permission.camera.request();

    if (status.isGranted) {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print("No image taken.");
      }
    } else {
      print("Permission denied to access camera.");
    }
  }

  Future<void> _pickImageFromGallery() async {
    // Request permission for gallery
    PermissionStatus status = await Permission.photos.request();

    if (status.isGranted) {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print("No image selected.");
      }
    } else {
      print("Permission denied to access gallery.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile", style: GoogleFonts.dmSans()),
        backgroundColor: Color(0xFF2B90B8),  // Set background color
        elevation: 0,  // Optional, to remove shadow
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Show a dialog to choose from gallery or camera
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Change Profile Picture", style: GoogleFonts.dmSans()),
                        content: Text("Choose an option", style: GoogleFonts.dmSans()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _pickImageFromGallery();
                              Navigator.pop(context);
                            },
                            child: Text("Gallery", style: GoogleFonts.dmSans()),
                          ),
                          TextButton(
                            onPressed: () {
                              _pickImageFromCamera();
                              Navigator.pop(context);
                            },
                            child: Text("Camera", style: GoogleFonts.dmSans()),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _image != null
                      ? FileImage(_image!)  // Show the selected image
                      : AssetImage('assets/images/profile.jpg') as ImageProvider,
                ),
              ),
              SizedBox(height: 16),
              Text("Change Profile Picture", style: GoogleFonts.dmSans()),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username', labelStyle: GoogleFonts.dmSans()),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone', labelStyle: GoogleFonts.dmSans()),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email', labelStyle: GoogleFonts.dmSans()),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'City', labelStyle: GoogleFonts.dmSans()),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age', labelStyle: GoogleFonts.dmSans()),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement save logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2B90B8),  // Use backgroundColor instead of primary
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Save Changes",
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

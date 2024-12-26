import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Profile Screen
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Container(
              color: Colors.blue[100],
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue[300],
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Name',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ViewProfileScreen()),
                          );
                        },
                        child: Text(
                          'View profile',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Access Grid
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                children: [
                  _buildQuickAccessItem(Icons.favorite, 'Favorites'),
                  _buildQuickAccessItem(Icons.bookmark, 'Bookmarks'),
                  _buildQuickAccessItem(Icons.article, 'My Articles'),
                ],
              ),
            ),

            // Perks Section
            _buildSectionHeader('Perks for you'),
            _buildListTile(Icons.star, 'Become a pro', () {
              // Navigate to Become a Pro screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BecomeProScreen()),
              );
            }),
            _buildListTile(Icons.group, 'Invite friends', () {
              // Implement the functionality for "Invite Friends"
            }),
            _buildListTile(Icons.newspaper, 'Personalized News', () {
              // Implement the functionality for "Personalized News"
            }),

            // General Section
            _buildSectionHeader('General'),
            _buildListTile(Icons.help, 'Help center', () {
              // Implement the functionality for "Help Center"
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue[300],
          radius: 30,
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      onTap: onTap,
    );
  }
}

// Placeholder for SettingsScreen
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Screen - Coming Soon!'),
      ),
    );
  }
}

// View Profile Screen
class ViewProfileScreen extends StatefulWidget {
  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  String name = 'User Name';
  String email = 'user@example.com';
  String phone = '+123 456 789';
  String address = '123, Main Street, City, Country';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue[300],
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Text('Name: $name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Email: $email', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Phone: $phone', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Address: $address', style: TextStyle(fontSize: 16)),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      name: name,
                      email: email,
                      phone: phone,
                      address: address,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    name = result['name'];
                    email = result['email'];
                    phone = result['phone'];
                    address = result['address'];
                  });
                }
              },
              child: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Become a Pro Screen with Features
class BecomeProScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Become a Pro'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'As a Pro User, you will get access to:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildProFeatureTile(Icons.lock, 'Ad-free experience'),
            _buildProFeatureTile(Icons.star, 'Exclusive Content'),
            _buildProFeatureTile(Icons.notifications, 'Early access to new features'),
            _buildProFeatureTile(Icons.chat, 'Priority support'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to PaymentPlansScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPlansScreen()),
                );
              },
              child: Text('Become a Pro'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProFeatureTile(IconData icon, String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 10),
          Expanded(child: Text(feature, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

// Payment Plans Screen
class PaymentPlansScreen extends StatefulWidget {
  @override
  _PaymentPlansScreenState createState() => _PaymentPlansScreenState();
}

class _PaymentPlansScreenState extends State<PaymentPlansScreen> {
  String selectedPlan = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Plans'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a Plan that Fits You:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue[800]),
            ),
            SizedBox(height: 20),
            _buildPlanTile('Basic Plan', '\$5/month', 'Basic features', false),
            _buildPlanTile('Pro Plan', '\$15/month', 'Pro features', false),
            _buildPlanTile('Premium Plan', '\$25/month', 'All features', true),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigate to Payment Screen (mocked as a simple dialog for this example)
                _showPaymentDialog(context);
              },
              child: Text('Proceed to Payment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanTile(String plan, String price, String description, bool isSelected) {
    return ListTile(
      tileColor: isSelected ? Colors.blue[50] : null,
      title: Text(plan, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: Text(description),
      trailing: Text(price),
      onTap: () {
        setState(() {
          selectedPlan = plan;
        });
      },
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Confirmation'),
        content: Text('Proceeding with the $selectedPlan.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement payment logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment successful!')));
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

// Edit Profile Screen
class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String address;

  EditProfileScreen({required this.name, required this.email, required this.phone, required this.address});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    addressController = TextEditingController(text: widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'name': nameController.text,
                  'email': emailController.text,
                  'phone': phoneController.text,
                  'address': addressController.text,
                });
              },
              child: Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
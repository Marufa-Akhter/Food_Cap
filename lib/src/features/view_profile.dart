import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() {
    final user = _auth.currentUser;
    setState(() {
      _user = user;
      _nameController.text = _user!.displayName ?? '';
      _emailController.text = _user!.email ?? '';
    });
  }

  Future<void> _updateProfile() async {
    try {
      await _user!.updateDisplayName(_nameController.text);
      await _user!.updateEmail(_emailController.text);
      if (_passwordController.text.isNotEmpty) {
        await _user!.updatePassword(_passwordController.text);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 16.0),
            Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 16.0),
            Text('Password', style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password (optional)',
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

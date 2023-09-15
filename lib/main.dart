import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'menubar.dart';

void main() {
  runApp(MyApp());
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool isLoggedIn = false; // You can change this based on your authentication logic

  void login() {
    // Implement your login logic here
    setState(() {
      isLoggedIn = true;
    });
  }

  void logout() {
    // Implement your logout logic here
    setState(() {
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? NavigationBarApp(logout: logout) : LoginScreen(login: login);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthenticationWrapper(),
    );
  }
}

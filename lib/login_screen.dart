import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pertemuan4_timer_menubar/menubar.dart';
import 'package:pertemuan4_timer_menubar/stopwatch_screen.dart';

/*
class LoginScreen extends StatelessWidget {
  final Function login;

  LoginScreen({required this.login});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Call the login function to authenticate the user
            login();
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
*/

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required void Function() login});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _foreKey = GlobalKey<FormState>();

  bool loggedIn = false;
  late String name;

  void _navigateToNavigationBar() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => NavigationExample(logout: () {
        // Implement logout logic here
        // You can set loggedIn to false and update the UI accordingly
        setState(() {
          loggedIn = false;
        });
      })),
    );
  }

  void _validate() {
    final form = _foreKey.currentState;
    if (!form!.validate()) {
      return;
    }

    final name = _nameController.text;
    final email = _emailController.text;

    setState(() {
      loggedIn = true;
      this.name = name;
    });

    // Call the function to navigate to NavigationBarApp
    _navigateToNavigationBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildSuccess() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check, color: Colors.orangeAccent),
        Text('Hi $name!'),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _foreKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (text) {
                if (text!.isEmpty) {
                  return 'Enter Email.';
                }
                final regex = RegExp('[^@]+@[^\.]+\..+');
                if (!regex.hasMatch(text)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Runner'),
              validator: (text) => text!.isEmpty ? 'Enter the runner\'s name.' : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: _validate,
                child: Text('Continue')
            )
          ],
        ),
      ),
    );
  }
}

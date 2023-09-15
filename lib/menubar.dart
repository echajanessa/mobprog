import 'package:flutter/material.dart';
import 'package:pertemuan4_timer_menubar/stopwatch_screen.dart';
import 'package:pertemuan4_timer_menubar/timer_screen.dart';

class NavigationBarApp extends StatelessWidget {
  final Function logout;

  NavigationBarApp({required this.logout});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavigationExample(logout: logout),
    );
  }
}



class NavigationExample extends StatefulWidget {
  final Function logout;

  NavigationExample({required this.logout});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // Call the logout function to log out the user
              widget.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.lightBlue[300],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.watch_later_outlined),
            icon: Icon(Icons.watch_later),
            label: 'Stopwatch',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer),
            selectedIcon: Icon(Icons.timer_outlined),
            label: 'Timer',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_outline),
            icon: Icon(Icons.person),
            label: 'About',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: StopWatch(),
        ),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: TimerScreen(),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
    );
  }
}

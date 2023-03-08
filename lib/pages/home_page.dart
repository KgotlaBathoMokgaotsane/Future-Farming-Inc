import 'package:app/tabs/add.dart';
import 'package:app/tabs/home.dart';
import 'package:app/tabs/message.dart';
import 'package:app/tabs/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../tabs/search.dart';

class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  final List<String> _titles = const [
    'Home',
    'Search',
    'Add',
    'Message',
    'Profile',
  ];

    final List<Widget> _tabs = const [
      HomeTab(),
      SearchTab(),
      AddTab(),
      MessageTab(),
      ProfileTab(),
    ];

  final user = FirebaseAuth.instance.currentUser!;

  //sign user out method
  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {//error at appBar
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.greenAccent,
        title: Text(_titles[_selectedIndex]),
        actions: [
          IconButton
            (onPressed: signUserOut,
            icon: Icon(Icons.logout),
            color: Colors.brown,
          )
        ],
      ),

      body: _tabs[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.greenAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            onTabChange: (newIndex)=> setState(() => _selectedIndex = newIndex),
            gap: 1,
            backgroundColor: Colors.greenAccent,
            color: Colors.brown,
            activeColor: Colors.lightBlueAccent,
            tabBackgroundColor: Colors.brown.shade800,
            padding: EdgeInsets.all(10),

            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),

              GButton(
                  icon: Icons.search,
                  text: 'Search',
              ),

              GButton(
                  icon: Icons.add_circle_outline_rounded,
                  text: 'Add',
              ),

              GButton(
                  icon: Icons.message,
                  text: 'Message',
              ),

              GButton(
                  icon: Icons.person,
                  text: 'Profile',
              ),

            ], //tabs
          ),
        ),
      ),

    );
  }
}

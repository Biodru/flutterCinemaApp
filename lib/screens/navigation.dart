import 'package:flutter/material.dart';
import 'home.dart';
import 'card.dart';
import 'settings.dart';
import 'package:cinema_town/storages/userDefaults.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Navigation extends StatefulWidget {
  static final id = 'navigation';
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  UserData userData = UserData();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  void updateEmail(String email) {
    setState(() {
      this.email = email;
    });
  }

  void updatePassword(String password) {
    setState(() {
      this.password = password;
    });
  }

  void tryLogIn(String email, String password) async {
    if (email != '' && password != '') {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print("Zalogowano");
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    userData.getEmail().then(updateEmail);
    userData.getPassword().then(updatePassword);
    tryLogIn(email, password);
    super.initState();
  }

  int _selectedIndex = 1;
  List<Widget> pages = [CardScreen(), HomeScreen(), Settings()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'CINEMATOWN',
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: Icon(
                  Icons.local_play,
                  size: _selectedIndex == 0 ? 35 : 25,
                  color: _selectedIndex == 0 ? Colors.orange : Colors.grey,
                ),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: _selectedIndex == 1 ? 35 : 25,
                  color: _selectedIndex == 1 ? Colors.orange : Colors.grey,
                ),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
                child: Icon(
                  Icons.settings,
                  size: _selectedIndex == 2 ? 35 : 25,
                  color: _selectedIndex == 2 ? Colors.orange : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

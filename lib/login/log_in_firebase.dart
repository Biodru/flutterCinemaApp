import 'package:flutter/material.dart';
import 'package:cinema_town/storages/userDefaults.dart';
import 'package:cinema_town/screens/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FireBaseUserLogin extends StatefulWidget {
  static const String id = 'FireBaseUserLogin_screen';
  @override
  _FireBaseUserLoginState createState() => _FireBaseUserLoginState();
}

class _FireBaseUserLoginState extends State<FireBaseUserLogin> {
  UserData userData = UserData();
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  bool selectedGender;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Email',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 25),
                          ),
                          Container(
                            width: 100,
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (input) {
                                email = input.toLowerCase();
                                userData.saveEmail(input);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Hasło',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 25),
                          ),
                          Container(
                            width: 100,
                            child: TextField(
                              obscureText: true,
                              onChanged: (input) {
                                password = input;
                                userData.savePassword(input);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RaisedButton(
                        onPressed: () async {
                          userData.logged(true);
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final newUser =
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              userData.saveEmail(email);
                              userData.savePassword(password);
                              Navigator.pushNamed(context, Navigation.id);
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

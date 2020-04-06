import 'package:flutter/material.dart';
import 'package:cinema_town/storages/userDefaults.dart';
import 'package:cinema_town/screens/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseUserRegister extends StatefulWidget {
  static const String id = 'FireBaseUserRegister_screen';
  @override
  _FireBaseUserRegisterState createState() => _FireBaseUserRegisterState();
}

class _FireBaseUserRegisterState extends State<FireBaseUserRegister> {
  UserData userData = UserData();
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  bool selectedGender = false;
  String _email;
  String _password;
  String _name;
  String _surName;

  void updateSex() {
    setState(() {
      selectedGender = !selectedGender;
    });
  }

  bool allow = false;

  void checkAllow() {
    if ((_email != null) &&
        (_password != null) &&
        (_name != null) &&
        (_surName != null)) {
      setState(() {
        allow = true;
      });
    } else {
      setState(() {
        allow = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryVariant,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'E-mail',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 87,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: _email,
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (input) {
                                  setState(() {
                                    checkAllow();
                                    _email = input.toLowerCase();
                                    userData.saveEmail(_email);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Hasło',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 87,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: _password,
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                onChanged: (input) {
                                  setState(() {
                                    checkAllow();
                                    _password = input;
                                    userData.savePassword(_password);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Imię',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 87,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: _name,
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                onChanged: (input) {
                                  setState(() {
                                    checkAllow();
                                    _name = input;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Nazwisko',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 87,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: _surName,
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                onChanged: (input) {
                                  setState(() {
                                    checkAllow();
                                    _surName = input;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Płeć',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                width: 87,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryVariant,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      updateSex();
                                      checkAllow();
                                    });
                                  },
                                  child: selectedGender
                                      ? Icon(
                                          Icons.local_play,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        )
                                      : Icon(
                                          Icons.close,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      allow
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: 250,
                                height: 57,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: FlatButton(
                                  onPressed: () async {
                                    userData.logged(true);
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    try {
                                      final newUser = await _auth
                                          .createUserWithEmailAndPassword(
                                              email: _email,
                                              password: _password);
                                      _firestore
                                          .collection('userData')
                                          .document(_email)
                                          .setData({
                                        'name': _name,
                                        'surname': _surName,
                                        'card': selectedGender
                                      });
                                      if (newUser != null) {
                                        userData.saveEmail(_email);
                                        userData.savePassword(_password);
                                        Navigator.pushNamed(
                                            context, Navigation.id);
                                      }
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Text(
                                    'Utwórz konto',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                              ),
                            )
                          : Text(
                              'Wypełnij wszystkie pola',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Theme.of(context).colorScheme.onError),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

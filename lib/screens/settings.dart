import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:cinema_town/storages/firebaseUserData.dart';
import 'package:cinema_town/storages/userDefaults.dart';
import 'package:cinema_town/login/logreg_screen.dart';

class Settings extends StatefulWidget {
  static const String id = 'settings';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Firestore _firestore = Firestore.instance;
  FirestoreUserData fireUserData = FirestoreUserData();

  UserData userData = UserData();

  bool fireBaseLogged;

  String _name = "";
  String _surname = "";
  String email;
  bool _card;
  bool allow = false;

  Widget content(card) {
    if (card == null) {
      return Text('Ładowanie');
    } else if (card == true) {
      return Icon(Icons.local_play);
    } else {
      return Icon(Icons.close);
    }
  }

  TextEditingController _textFieldController = TextEditingController();

  _displayNameDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Zmień dane'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: _name),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Zmień'),
                onPressed: () {
                  setState(() {
                    _name = _textFieldController.text;
                    _firestore
                        .collection('userData')
                        .document(email)
                        .updateData({'name': _name});
                    Navigator.of(context).pop();
                  });
                },
              ),
              FlatButton(
                child: new Text('Anuluj'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _displaySurNameDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Zmień dane'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: _surname),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Zmień'),
                onPressed: () {
                  setState(() {
                    _surname = _textFieldController.text;
                    _firestore
                        .collection('userData')
                        .document(email)
                        .updateData({'surname': _surname});
                    Navigator.of(context).pop();
                  });
                },
              ),
              FlatButton(
                child: new Text('Anuluj'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _displaySexDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Zmień dane'),
            content: Container(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _card = true;
                          _firestore
                              .collection('userData')
                              .document(email)
                              .updateData({'card': _card});
                        });
                      },
                      child: Icon(
                        Icons.local_play,
                        color: _card == true
                            ? Theme.of(context).accentColor
                            : Colors.black45,
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _card = false;
                          _firestore
                              .collection('userData')
                              .document(email)
                              .updateData({'gender': _card});
                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: _card == false
                            ? Theme.of(context).accentColor
                            : Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Zmień'),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              ),
              FlatButton(
                child: new Text('Anuluj'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void checkAllow() {
    setState(() {
      if ((_name == '' || _name == null) &&
          (_surname == '' || _surname == null)) {
        allow = false;
      } else {
        allow = true;
      }
    });
  }

  void fireBaseUserData(bool fireBase) {
    if (fireBase == true) {
      fireUserData.getUserName().then(updateName);
      fireUserData.getUserSurName().then(updateSurName);
      fireUserData.getUserCard().then(updateCard);
      userData.getEmail().then(updateEmail);
    } else {
      userData.getEmail().then(updateEmail);
    }
  }

  @override
  void initState() {
    userData.getLogged().then(fireBaseUserData);
    super.initState();
  }

  void updateEmail(String email) {
    setState(() {
      this.email = email;
    });
  }

  void updateName(String name) {
    setState(() {
      this._name = name;
    });
  }

  void updateSurName(String surname) {
    setState(() {
      this._surname = surname;
    });
  }

  void updateCard(bool card) {
    setState(() {
      this._card = card;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
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
                      'Imię',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        width: 87,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              _displayNameDialog(context);
                            });
                          },
                          child: Text(
                            _name,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
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
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        width: 87,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              _displaySurNameDialog(context);
                            });
                          },
                          child: Text(
                            _surname,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
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
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        width: 87,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              _displaySexDialog(context);
                            });
                          },
                          child: _card
                              ? Icon(
                                  Icons.local_play,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                )
                              : Icon(
                                  Icons.close,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 250,
                  height: 57,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      userData.logged(false);
                      Navigator.pushNamed(context, LogRegOption.id);
                    },
                    child: Text(
                      'Wyloguj',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

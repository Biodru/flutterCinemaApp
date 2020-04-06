import 'package:flutter/material.dart';
import 'package:cinema_town/storages/userDefaults.dart';
import 'package:cinema_town/login/firebase_user_register.dart';
import 'package:cinema_town/login/log_in_firebase.dart';

class LogRegOption extends StatefulWidget {
  static const String id = 'logreg_screen';
  @override
  _LogRegOptionState createState() => _LogRegOptionState();
}

class _LogRegOptionState extends State<LogRegOption> {
  UserData userData = UserData();
  bool logged = true;
  String name = "";

  bool fireBaseLogPressed = false;

  @override
  void initState() {
    super.initState();
  }

  void updateName(String name) {
    setState(() {
      this.name = name;
    });
  }

  void updateLogged(bool logged) {
    setState(() {
      this.logged = logged;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Masz już konto?',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 250,
                height: 57,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, FireBaseUserLogin.id);
                  },
                  child: Text(
                    'Zaloguj',
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'lub',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 250,
                height: 57,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, FireBaseUserRegister.id);
                  },
                  child: Text(
                    'Zarejestruj',
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

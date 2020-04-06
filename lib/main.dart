import 'package:flutter/material.dart';
import 'screens/navigation.dart';
import 'storages/userDefaults.dart';
import 'login/logreg_screen.dart';
import 'login/firebase_user_register.dart';
import 'login/log_in_firebase.dart';
import 'package:cinema_town/screens/card.dart';
import 'package:cinema_town/screens/home.dart';
import 'package:cinema_town/screens/navigation.dart';
import 'screens/settings.dart';

UserData userData = UserData();
Widget _defaultHome = LogRegOption();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await userData.getLogged();
  if (_result == true) {
    _defaultHome = Navigation();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.orange,
        canvasColor: Colors.black,
      ),
      home: _defaultHome,
      routes: {
        Navigation.id: (context) => Navigation(),
        LogRegOption.id: (context) => LogRegOption(),
        HomeScreen.id: (context) => HomeScreen(),
        Settings.id: (context) => Settings(),
        CardScreen.id: (context) => CardScreen(),
        FireBaseUserRegister.id: (context) => FireBaseUserRegister(),
        FireBaseUserLogin.id: (context) => FireBaseUserLogin()
      },
    );
  }
}

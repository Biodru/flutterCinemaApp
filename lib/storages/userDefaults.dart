import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  //CodeNames
  String _email = 'email';
  String _password = 'password';
  String _loggedIn = 'logged';

  //Saving data
  saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_email, email);
  }

  savePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_password, password);
  }

  logged(bool logged) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_loggedIn, logged);
  }

  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString(_email);
    return email;
  }

  Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString(_password);
    return password;
  }

  Future<bool> getLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool logged = prefs.getBool(_loggedIn);
    return logged;
  }
}

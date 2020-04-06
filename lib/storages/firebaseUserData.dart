import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUserData {
  FirebaseUser _fireUser;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;

  Future<String> getUserName() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        _fireUser = user;
        final userData = await _firestore
            .collection('userData')
            .document(_fireUser.email)
            .get();
        return userData.data['name'].toString();
      }
    } catch (e) {
      print(e);
      return "Genric Name";
    }
  }

  Future<String> getUserSurName() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        _fireUser = user;
        final userData = await _firestore
            .collection('userData')
            .document(_fireUser.email)
            .get();
        return userData.data['surname'].toString();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> getUserCard() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        _fireUser = user;
        final userData = await _firestore
            .collection('userData')
            .document(_fireUser.email)
            .get();
        return userData.data['card'];
      }
    } catch (e) {
      print(e);
    }
  }
}

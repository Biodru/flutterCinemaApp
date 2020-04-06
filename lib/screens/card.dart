import 'package:flutter/material.dart';
import 'package:cinema_town/storages/firebaseUserData.dart';
import 'package:cinema_town/storages/userDefaults.dart';
import 'package:cinema_town/widgets/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CardScreen extends StatefulWidget {
  static const String id = 'card';
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  FirestoreUserData _fireData = FirestoreUserData();
  Firestore _firestore = Firestore.instance;
  UserData userData = UserData();
  String _name = '';
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

  void updateName(String name) {
    setState(() {
      this._name = name;
    });
  }

  @override
  void initState() {
    userData.getEmail().then(updateEmail);
    _fireData.getUserName().then(updateName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.black,
              child: Center(
                child: Text(
                  "Bilety",
                  style: TextStyle(color: Colors.orange, fontSize: 20),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection("userData")
                  .document(email)
                  .collection("tickets")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final cards = snapshot.data.documents;
                  List<Ticket> cardWidgets = [];
                  for (var card in cards) {
                    final movie = card.data['movie'];
                    final date = card.data['date'];
                    final row = card.data['row'];
                    final place = card.data['seat'];
                    final cinema = card.data['cinema'];
                    final room = card.data['room'];
                    final cardWidget = Ticket(
                      movie: movie,
                      date: date,
                      row: row,
                      place: place,
                      cinema: cinema,
                      email: email,
                      room: room,
                    );
                    cardWidgets.add(cardWidget);
                  }
                  return Column(
                    children: cardWidgets,
                  );
                }
                return Column(
                  children: <Widget>[
                    Center(
                      child: Text('Brak kart'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cinema_town/widgets/movie_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  static final id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Firestore _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: SafeArea(
        child: new Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Repertuar',
                  style: TextStyle(color: Colors.orange, fontSize: 15),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("movies").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final cards = snapshot.data.documents;
                  List<MovieTile> cardWidgets = [];
                  for (var card in cards) {
                    final name = card.data["name"].toString();
                    final url = card.data["image"].toString();
                    var now = DateTime.now();
                    final date = card.data['date'].toDate();
                    final diff = now.difference(date).inSeconds;
                    if (diff > 0) {
                      final cardWidget = MovieTile(
                        title: name,
                        url: url,
                      );
                      cardWidgets.add(cardWidget);
                    }
                  }
                  return Container(
                    child: new Expanded(
                      flex: 1,
                      child: new ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: cardWidgets,
                      ),
                    ),
                  );
                }
                return Column(
                  children: <Widget>[
                    Center(
                      child: Text("Brak filmów"),
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Wkrótce',
                  style: TextStyle(color: Colors.orange, fontSize: 15),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("movies").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final cards = snapshot.data.documents;
                  List<MovieTile> cardWidgets = [];
                  for (var card in cards) {
                    final name = card.data["name"].toString();
                    final url = card.data["image"].toString();
                    var now = DateTime.now();
                    final date = card.data['date'].toDate();
                    final diff = now.difference(date).inSeconds;
                    if (diff < 0) {
                      final cardWidget = MovieTile(
                        title: name,
                        url: url,
                      );
                      cardWidgets.add(cardWidget);
                    }
                  }
                  return Container(
                    child: new Expanded(
                      flex: 1,
                      child: new ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: cardWidgets,
                      ),
                    ),
                  );
                }
                return Column(
                  children: <Widget>[
                    Center(
                      child: Text("Brak filmów"),
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Pokazy Przedpremierowe',
                  style: TextStyle(color: Colors.orange, fontSize: 15),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("movies").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final cards = snapshot.data.documents;
                  List<MovieTile> cardWidgets = [];
                  for (var card in cards) {
                    final name = card.data["name"].toString();
                    final url = card.data["image"].toString();
                    var now = DateTime.now();
                    final date = card.data['date'].toDate();
                    final early = card.data['early'];
                    final diff = now.difference(date).inSeconds;
                    if (diff < 0 && early) {
                      final cardWidget = MovieTile(
                        title: name,
                        url: url,
                      );
                      cardWidgets.add(cardWidget);
                    }
                  }
                  return Container(
                    child: new Expanded(
                      flex: 1,
                      child: new ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: cardWidgets,
                      ),
                    ),
                  );
                }
                return Column(
                  children: <Widget>[
                    Center(
                      child: Text("Brak filmów"),
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

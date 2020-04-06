import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'showing.dart';

class BottomInfo extends StatefulWidget {
  final String url;
  final String title;
  BottomInfo({this.url, this.title});

  @override
  _BottomInfoState createState() => _BottomInfoState();
}

class _BottomInfoState extends State<BottomInfo> {
  Firestore _firestore = Firestore.instance;
  String _selectedCinema = "--";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black.withOpacity(0.3),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                maxRadius: MediaQuery.of(context).size.height / 5,
                backgroundImage: NetworkImage(widget.url),
              ),
              Text(
                widget.title,
                style: TextStyle(color: Colors.orange),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("cinemas").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final cards = snapshot.data.documents;
                    List<DropdownMenuItem> movies = [];
                    for (var card in cards) {
                      final title = card.documentID;
                      final cardWidget = DropdownMenuItem(
                        child: Text(title),
                        value: "$title",
                      );
                      movies.add(cardWidget);
                    }
                    return DropdownButton(
                      items: movies,
                      onChanged: (value) {
                        setState(() {
                          _selectedCinema = value;
                        });
                      },
                      style: TextStyle(color: Colors.white),
                      hint: Text(
                        _selectedCinema,
                        style: TextStyle(color: Colors.white),
                      ),
                      isExpanded: false,
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Center(
                          child: Text('Brak kart'),
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("showings").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final cards = snapshot.data.documents;
                    List<Showing> showings = [];
                    for (var card in cards) {
                      var formatter = new DateFormat('dd/MM/yyyy hh:mm');
                      final date = formatter
                          .format(card.data['start'].toDate())
                          .toString();
                      final movieT = card.data['movie'].toString();
                      final cinemaT = card.data['cinema'].toString();
                      final id = card.documentID.toString();
                      final cardWidget = new Showing(
                        date: date,
                        movie: movieT,
                        cinemaCity: cinemaT,
                        id: id,
                      );
                      if (movieT == widget.title &&
                          cinemaT == _selectedCinema) {
                        showings.add(cardWidget);
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: showings,
                      ),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Center(
                          child: Text('Brak kart'),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

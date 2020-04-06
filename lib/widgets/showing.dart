import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinema_town/storages/userDefaults.dart';

class Showing extends StatefulWidget {
  final String date;
  final String movie;
  final String cinemaCity;
  final String id;
  const Showing({this.date, this.movie, this.cinemaCity, this.id});

  @override
  _ShowingState createState() => _ShowingState();
}

class _ShowingState extends State<Showing> {
  Firestore _firestore = Firestore.instance;

  String _selectedRow = "--";
  String _selectedPlace = "--";
  String _email;
  UserData _userData = UserData();
  bool _allow = false;

  void checkAllow() {
    if (_selectedRow != "--" || _selectedPlace != "--") {
      setState(() {
        _allow = true;
      });
    }
  }

  void updateEmail(String email) {
    setState(() {
      this._email = email;
    });
  }

  @override
  void initState() {
    _userData.getEmail().then(updateEmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: Text('Kupujesz bilet?'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Film: ${this.widget.movie}\nData: ${this.widget.date}\nKino: ${this.widget.cinemaCity}\nRząd: $_selectedRow Miejsce: $_selectedPlace",
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              StreamBuilder<QuerySnapshot>(
                                stream: _firestore
                                    .collection("showings")
                                    .document(this.widget.id)
                                    .collection("seats")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final cards = snapshot.data.documents;
                                    List<DropdownMenuItem> movies = [];
                                    for (var card in cards) {
                                      final title = card.documentID.toString();
                                      final cardWidget = DropdownMenuItem(
                                        child: Text(title),
                                        value: "$title",
                                      );
                                      movies.add(cardWidget);
                                    }
                                    return DropdownButton(
                                      style: TextStyle(color: Colors.white),
                                      items: movies,
                                      onChanged: (value) {
                                        checkAllow();
                                        setState(() {
                                          _selectedRow = value;
                                        });
                                      },
                                      hint: Text(
                                        _selectedRow,
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
                              StreamBuilder<QuerySnapshot>(
                                stream: _firestore
                                    .collection("showings")
                                    .document(this.widget.id)
                                    .collection("seats")
                                    .document(_selectedRow)
                                    .collection("place")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final cards = snapshot.data.documents;
                                    List<DropdownMenuItem> movies = [];
                                    for (var card in cards) {
                                      final title = card.documentID.toString();
                                      final available = card.data["available"];
                                      final cardWidget = DropdownMenuItem(
                                        child: Text(title),
                                        value: "$title",
                                      );
                                      if (available) {
                                        movies.add(cardWidget);
                                      }
                                    }
                                    return DropdownButton(
                                      style: TextStyle(color: Colors.white),
                                      items: movies,
                                      onChanged: (value) {
                                        checkAllow();
                                        setState(() {
                                          _selectedPlace = value;
                                        });
                                      },
                                      hint: Text(
                                        _selectedPlace,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        color: _allow ? Colors.orange : Colors.grey,
                        onPressed: () {
                          if (_allow) {
                            String data =
                                widget.date.replaceAll('/', '').trim();
                            _firestore
                                .collection("userData")
                                .document(_email)
                                .collection("tickets")
                                .document(data.replaceAll(" ", ""))
                                .setData({
                              'date': widget.date,
                              'movie': widget.movie,
                              'cinema': widget.cinemaCity,
                              'row': _selectedRow,
                              'seat': _selectedPlace
                            });
                          }
                        },
                        child: Text("Tak!"),
                      ),
                      FlatButton(
                        color: Colors.orange,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Anuluj"),
                      ),
                    ],
                    backgroundColor: Colors.orange,
                    elevation: 24.0,
                  );
                }));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            child: Text(
              widget.date,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Ticket extends StatefulWidget {
  final String movie;
  final String cinema;
  final String date;
  final String row;
  final String place;
  final String email;
  final String room;

  const Ticket(
      {this.movie,
      this.cinema,
      this.date,
      this.row,
      this.place,
      this.email,
      this.room});

  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(widget.cinema),
                    Text(widget.date),
                  ],
                ),
              ),
              Text(
                widget.movie,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Rząd: ${widget.row} miejsce: ${widget.place}"),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _show = !_show;
                        });
                      },
                      child: Text('QR'),
                    ),
                  ],
                ),
              ),
              _show
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: QrImage(
                          version: QrVersions.auto,
                          data: "{"
                              "email: ${this.widget.email},"
                              "movie: ${this.widget.movie},"
                              "row: ${this.widget.row},"
                              "place: ${this.widget.place},"
                              "cinema: ${this.widget.cinema},"
                              "date: ${this.widget.date}",
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  : Container(),
            ],
          )),
    );
  }
}

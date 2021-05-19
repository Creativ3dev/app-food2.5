import 'package:app_food/food/model/resto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildRestoCard(BuildContext context, DocumentSnapshot document) {
  final resto= Resto.fromSnapshot(document);

  return new Container(
    child: Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    resto.name,
                    style: GoogleFonts.seymourOne(fontSize: 20.0),
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(children: <Widget>[
                  Text(
                      resto.ville),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[

                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {/*
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailCardView(resto: resto)),
          );*/
        },
      ),
    ),
  );
}

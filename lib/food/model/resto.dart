import 'dart:ffi';

import 'package:app_food/food/model/values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class restos {
  String id;
  String name;
  String formatted_address;
  String user_ratings_totals;
  /*  String compound_code;*/
/*  List<dynamic> photo;*/
  String place_id;
  String photo;
  String type;
  String ville;
  String lat;
  String lng;
  bool verifie;
  String numero;
  String menu;
  String siteweb;
  String siteadmin;
  String horaire;
  double rating;

  restos(
      {this.id,
      this.name,
      this.formatted_address,
      this.user_ratings_totals,
      /*this .compound_code,*/
      this.rating,
      this.place_id,
      this.photo,
      this.type,
      this.ville,
      this.horaire,
      this.lat,
      this.lng,
      this.menu,
      this.siteadmin,
      this.siteweb,
      this.verifie,
      this.numero});


  factory restos.fromDoc(DocumentSnapshot doc) {
    return restos(
      id :doc.id,
      name :doc['name'],
      formatted_address :doc['formatted_address'],
      user_ratings_totals : doc['user_ratings_totals'],
      rating : doc['rating'].toDouble(),
      /* compound_code = doc['compound_code'],*/
      place_id : doc['place_id'],
      photo : doc['photo'],
      type : doc['type'],
      ville :doc['ville'],
      lat : doc['lat'],
      lng : doc['lng'],
      verifie : doc['verifie'],
      numero : doc['numero'],
      menu : doc['menu'],
      siteweb : doc['siteweb'],
      siteadmin : doc['siteadmin'],
      horaire : doc['horaire'],
    );
  }
}

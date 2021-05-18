import 'dart:ffi';

import 'package:app_food/food/model/values.dart';
import 'package:app_food/food/model/values.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

typedef RestoPressedCallback = void Function(String restoId);

typedef CloserestoPressedCallback = void Function();

class Resto {
  final String id;
  final String name;
  final String formatted_address;
  final String user_ratings_totals;
  /* final String compound_code;*/
/*final  List<dynamic> photo;*/
  final String place_id;
  final String photo;
  final String type;
  final String ville;
  final String lat;
  final String lng;
  final bool verifie;
  final String numero;
  final String menu;
  final String siteweb;
  final String siteadmin;
  final String horaire;

  final DocumentReference reference;

  Resto._(
      {this.name,
      this.formatted_address,
      this.user_ratings_totals,
      /*this .compound_code,*/
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
      this.numero})
      : id = null,
  reference = null;

  Resto.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        name = snapshot.data()['name'],
        formatted_address = snapshot.data()['formatted_address'],
        user_ratings_totals = snapshot.data()['user_ratings_totals'],
        /* compound_code = snapshot.data()['compound_code'],*/
        photo = snapshot.data()['photo'],
        place_id = snapshot.data()['place_id'],
        type = snapshot.data()['type'],
        ville = snapshot.data()['ville'],
        lat = snapshot.data()['lat'],
        lng = snapshot.data()['lng'],
        verifie = snapshot.data()['verifie'],
        numero = snapshot.data()['numero'],
        menu = snapshot.data()['menu'],
        siteweb = snapshot.data()['siteweb'],
        siteadmin = snapshot.data()['siteadmin'],
        horaire = snapshot.data()['horaire'],
        reference = snapshot.reference;

  factory Resto.random() {
    return Resto._(
      /*ville:getRandomCoumpound(),*/
      type: getRandomType(),
      formatted_address: getRandomAddress(),
      name: getRandomName(),
      /* photo: getRandomPhoto(),*/
    );
  }
}

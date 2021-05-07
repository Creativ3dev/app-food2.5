import 'package:app_food/food/model/values.dart';
import 'package:app_food/food/model/values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

typedef RestoPressedCallback = void Function(String restoId);

typedef CloserestoPressedCallback = void Function();

class Resto {
  final String id;
  final String name;
  final String formatted_address;
  final String rating;
  final String user_ratings_totals;
 /* final String compound_code;*/
/*final  List<dynamic> photo;*/
  final String place_id;
  final String photo;
  final String categorie;
final String coumpound;

  final DocumentReference reference;

  Resto._({this.name,this.formatted_address, this.rating, this.user_ratings_totals, /*this .compound_code,*/ this.place_id, this.photo,  this.categorie, this.coumpound })
      : id = null,
        reference = null;

  Resto.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        name = snapshot.data()['name'],
        formatted_address = snapshot.data()['formatted_address'],
        rating = snapshot.data()['rating'],
        user_ratings_totals = snapshot.data()['user_ratings_totals'],
       /* compound_code = snapshot.data()['compound_code'],*/
       photo = snapshot.data()['photo'],
        place_id = snapshot.data()['place_id'],
        categorie = snapshot.data()['categorie'],
          coumpound = snapshot.data()['coumpound'],
        reference = snapshot.reference;

  factory Resto.random() {
    return Resto._(
      coumpound:getRandomCoumpound(),
categorie: getRandomType(),
      formatted_address: getRandomAddress(),
      name: getRandomName(),
     /* photo: getRandomPhoto(),*/
    );
  }
}

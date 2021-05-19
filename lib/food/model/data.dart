
import 'package:app_food/food/model/resto.dart';
import 'package:app_food/food/model/filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> addresto(Resto resto) {
  final restos = FirebaseFirestore.instance.collection('resto');
  return restos.add({
    /*'rating': resto.rating,*/
   'type': resto.type,
    'formatted_address': resto.formatted_address,
    'name': resto.name,
    'user_ratings_totals': resto.user_ratings_totals,
   /* 'photo_reference': resto.photo,*/
    /*'compound_code': resto.compound_code,*/
    'place_id': resto.place_id,
    'ville' : resto.ville



  });
}

Stream<QuerySnapshot> loadAllrestos() {
  return FirebaseFirestore.instance
      .collection('resto')
      .orderBy('type', descending: true)
      .limit(800)
      .snapshots();
}

List<Resto> getrestosFromQuery(QuerySnapshot snapshot) {
  return snapshot.docs.map((DocumentSnapshot doc) {
    return Resto.fromSnapshot(doc);
  }).toList();
}

Future<Resto> getresto(String restosId) {
  return FirebaseFirestore.instance
      .collection('resto')
      .doc(restosId)
      .get()
      .then((DocumentSnapshot doc) => Resto.fromSnapshot(doc));
}
/*
Future<void> addReview({String restoId, Review review}) {
  final resto =
  FirebaseFirestore.instance.collection('resto').doc(restoId);
  final newReview = resto.collection('rating').doc();

  return FirebaseFirestore.instance.runTransaction((Transaction transaction) {
    return transaction
        .get(resto)
        .then((DocumentSnapshot doc) => resto.fromSnapshot(doc))
        .then((resto fresh) {
      final newRatings = fresh.numRatings + 1;
      final newAverage =
          ((fresh.numRatings * fresh.avgRating) + review.rating) / newRatings;

      transaction.update(resto, {
        'numRatings': newRatings,
        'avgRating': newAverage,
      });

      transaction.set(newReview, {
        'rating': review.rating,
        'text': review.text,
        'userName': review.userName,
        'timestamp': review.timestamp ?? FieldValue.serverTimestamp(),
        'userId': review.userId,
      });
    });
  });
}*/

Stream<QuerySnapshot> loadFilteredrestos(Filter filter) {
  Query collection = FirebaseFirestore.instance.collection('resto');
  if (filter.ville != null) {
    collection = collection.where('ville', isEqualTo: filter.ville);
  }
 if (filter.type != null) {
    collection = collection.where('type', isEqualTo: filter.type);
  }
  if (filter.coumpound!= null) {
    collection = collection.where('coumpound', isEqualTo: filter.coumpound);
  }
  return collection
      .orderBy(filter.rating ?? 'rating', descending: true)
      .limit(800)
      .snapshots();
}

/*
void addrestosBatch(List<resto> restos) {
  restos.forEach((Resto resto) {
    addresto(resto);
  });
}*/
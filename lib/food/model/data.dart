
import 'package:app_food/food/Constants/Constants.dart';
import 'package:app_food/food/model/resto.dart';
import 'package:app_food/food/model/filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class data {




  static void updateRestoData(restos resto) {
    restosRef.doc(resto.id).update({
      'name': resto.name,
      'type': resto.type,
      'ville': resto.ville,
      'photo': resto.photo,
    });
  }

 static Future<QuerySnapshot> searchName(String name) async {
    Future<QuerySnapshot> restos = restosRef
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThan: name + 'z')
        .get();

    return restos;
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


/*
void addrestosBatch(List<resto> restos) {
  restos.forEach((Resto resto) {
    addresto(resto);
  });
}*/
}
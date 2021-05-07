import 'package:app_food/food/model/resto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('resto')
        .where('searchKey',
        isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();

  }
}
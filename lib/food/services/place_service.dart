import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart';

// For storing our result
class Place {
  String streetNumber;
  String street;
  String city;
  String zipCode;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}
class Suggestion {
  final String placeId;
  final String description;

  Suggestion({this.placeId, this.description});
  static Suggestion fromJson(Map<String, dynamic> json) {
    return Suggestion(
      placeId: json['placeId'],
      description: json['description'],
    );
  }
}


class PlaceApiProvider {
  final Client _client = Client();
  final Dio _dio = Dio();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyCRmIqs1KOovPpu1q8WtlJWPx3qCIJJuIA';
  static final String iosKey = 'AIzaSyC6niJerNpoesPXCkx4nnPYEVmzQDj53A8';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    try {
      final response = await this._dio.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: {
          "input": input,
          "key": apiKey,
          "types": "establishment",
          "language": "fr-FR",
          "components": "country:Mq",
        },);

      final List<Suggestion> suggestions = (response
          .data['predictions'] as List)
          .map((item) => Suggestion.fromJson(item))
          .toList();
      return suggestions;
    }
    catch (e) {
      return null;
    }
  }


}

import 'dart:core';
import 'dart:core';
import 'dart:math';

final formatted_address = [
  'Albuquerque',

];
final categorie = [


];
final coumpound= [


];

final _words = [
  'Bar',
  'Deli',
  'Diner',
  'Fire',
  'Grill',
  'Drive Thru',
  'Place',
  'Best',
  'Spot',
  'Trattoria',
  'Steakhouse',
  'Churrasco',
  'Tavern',
  'Cafe',
  'Pop-up',
  'Yummy',
  'Belly',
  'Snack',
  'Fast',
  'Turbo',
  'Hyper',
  'Prime',
  'Eatin\'',
];

final _reviewTextPerRating = {
  1: [
    'Would never eat here again!',
    'Such an awful place!',
    'Not sure if they had a bad day off, but the food was very bad.'
  ],
  2: [
    'Not my cup of tea.',
    'Unlikely that we will ever come again.',
    'Quite bad, but I\'ve had worse!'
  ],
  3: [
    'Exactly okay :/',
    'Unimpressed, but not disappointed!',
    '3 estrellas y van que arden.'
  ],
  4: [
    'Actually pretty good, would recommend!',
    'I really like this place, I come quite often!',
    'A great experience, as usual!'
  ],
  5: [
    'This is my favorite place. Literally',
    'This place is ALWAYS great!',
    'I recommend this to all my friends and family!'
  ],
};

final random = Random();

String getRandomReviewText(int rating) {
  final reviews = _reviewTextPerRating[rating];
  return reviews[random.nextInt(reviews.length)];
}

String getRandomName() {
  final firstWord = random.nextInt(_words.length);
  var nextWord;
  do {
    nextWord = random.nextInt(_words.length);
  } while (firstWord == nextWord);
  return '${_words[firstWord]} ${_words[nextWord]}';
}

String getRandomType() {
  return categorie[random.nextInt(categorie.length)];
}



String getRandomAddress() {
  return formatted_address[random.nextInt(formatted_address.length)];
}

String getRandomPhoto() {
  final photoId = random.nextInt(21) + 1;
  return 'https://storage.googleapis.com/carbon-modem-303215.appspot.com/food_$photoId.jpeg';
}

/*String getRandomCode() {
 var code;

 /*return '${code.substring(8)}';*/
 


}

 */
String getRandomCoumpound() {
var coumpound;
  if(coumpound==null) {
    print('cest null');
  }
  else{

  return coumpound='${"aefz"}';
}}
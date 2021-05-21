import 'dart:async';
import 'package:app_food/food/model/data.dart' as data;
import 'package:app_food/food/model/resto.dart';
import 'package:app_food/food/utils/FoodColors.dart';
import 'package:app_food/food/utils/FoodString.dart';
import 'package:app_food/food/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sliver_fab/sliver_fab.dart';

import 'FoodDescription.dart';
import 'FoodRestaurantsDescription.dart';

/*class RestoPage extends StatefulWidget {
  static String tag = '/FoodViewRestaurants';
  static const route = '/resto';

  final String _restoId;
  final Resto resto;

  RestoPage({Key key, @required String restoId, this.resto})
      : _restoId = restoId,
        super(key: key);

  @override
  _RestoPageState createState() => _RestoPageState(restoId: _restoId);
}

class _RestoPageState extends State<RestoPage> {
  var queryResultSet = [];
  var tempSearchStore = [];
  Widget iconWithTitle(var icon, var value) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(icon, color: food_textColorSecondary, size: 18)),
          ),
          TextSpan(
              text: value,
              style: primaryTextStyle(size: 16, color: food_textColorPrimary)),
        ],
      ),
    );
  }

  Widget mOption(var icon, var value) {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(icon, color: food_colorPrimary, size: 20),
          Text(value, style: primaryTextStyle(size: 16)),
        ],
      ),
    );
  }

  _RestoPageState({@required String restoId}) {
    FirebaseAuth.instance
        .signInAnonymously()
        .then((UserCredential userCredential) {
     /* data.getresto(restoId).then((Resto resto)*/ {
        _currentReviewSubscription?.cancel();
        setState(() {
          if (userCredential.user.displayName == null ||
              userCredential.user.displayName.isEmpty) {
            _userName = 'Anonymous (${kIsWeb ? "Web" : "Mobile"})';
          } else {
            _userName = userCredential.user.displayName;
          }
       /*   _resto = resto;*/
          _userId = userCredential.user.uid;

          // Initialize the reviews snapshot...
          _currentReviewSubscription = _resto.reference
              .collection('name')
              .orderBy('timestamp', descending: true)
              .snapshots()
              .listen((QuerySnapshot reviewSnap) {
            setState(() {
              _isLoading = false;
            });
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _currentReviewSubscription?.cancel();
    super.dispose();
  }

  bool _isLoading = true;
  StreamSubscription<QuerySnapshot> _currentReviewSubscription;

  Resto _resto;
  String _userId;
  String _userName;
  List<Review> _reviews = <Review>[];

  /* void _onCreateReviewPressed(BuildContext context) async {
    final newReview = await showDialog<Review>(
      context: context,
      builder: (_) => ReviewCreateDialog(
        userId: _userId,
        userName: _userName,
      ),
    );
    if (newReview != null) {
      // Save the review
      return data.addReview(
        restaurantId: _restaurant.id,
        review: newReview,
      );
    }
  } */
/*
  void _onAddRandomReviewsPressed() async {
    // Await adding a random number of random reviews
    final numReviews = Random().nextInt(5) + 5;
    for (var i = 0; i < numReviews; i++) {
      await data.addReview(
        restaurantId: _restaurant.id,
        review: Review.random(
          userId: _userId,
          userName: _userName,
        ),
      );
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Builder(
                builder: (context) => SliverFab(
                        floatingWidget: Icon(Icons.add),
                        floatingPosition: FloatingPosition(right: 16),
                        expandedHeight: RestoAppBar.appBarHeight,
                        slivers: <Widget>[
                          RestoAppBar(
                            resto: _resto,
                            onClosePressed: () => Navigator.pop(context),
                          ),
                          _reviews.isNotEmpty
                              ? SliverPadding(
                                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                                  sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        return Card(
                                          margin: EdgeInsets.all(15),
                                          child: Container(
                                            color: Colors
                                                .blue[100 * (index % 9 + 1)],
                                            height: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              _resto.ville,
                                              style: TextStyle(fontSize: 30),
                                            ),
                                          ),
                                        );
                                      },
                                      childCount: 1000, // 1000 list items
                                    ),
                                  ),
                                  /* delegate: SliverChildListDelegate(_reviews
                    .map((Review review) =>
                    RestaurantReview(review: review))
                    .toList()),
              ),
            )*/
                                )
                              : SliverFillRemaining(
                                  hasScrollBody: true,
                                  child: Container(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                boxShadow: defaultBoxShadow(),
                                                color: white),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(_resto.type,
                                                      style: primaryTextStyle(
                                                          color:
                                                              food_color_red)),
                                                  Row(
                                                    children: [
                                                      Text(_resto.name,
                                                          style:
                                                              primaryTextStyle(
                                                                  size: 20)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Icon(
                                                          Icons.verified_user,
                                                          color: Colors.green,
                                                          size: 20.0,
                                                          semanticLabel: 'text',
                                                        ),
                                                      ),
                                                      Text('verifié'),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(_resto.ville,
                                                          style: primaryTextStyle(
                                                              color:
                                                                  food_textColorSecondary)),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                food_textColorSecondary),
                                                        width: 4,
                                                        margin: EdgeInsets.only(
                                                            right: 16, left: 4),
                                                        height: 4,
                                                      ),
                                                      Text(food_lbl_3_4_km_away,
                                                          style: primaryTextStyle(
                                                              color:
                                                                  food_textColorSecondary)),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Divider(
                                                      height: 5,
                                                      color: food_view_color),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      mOption(Icons.call,
                                                          food_lbl_call),
                                                      // mOption(Icons.star_border, food_lbl_reviews),
                                                      // mOption(Icons.add_box, food_lbl_add_photo),
                                                      mOption(Icons.directions,
                                                          food_lbl_direction),
                                                    ],
                                                  ),
                                                  SizedBox(height: 16),
                                                  Row(children: <Widget>[
                                                    Expanded(
                                                      flex: 1,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          FoodDescription()
                                                              .launch(context);
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 8,
                                                                  bottom: 8),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  food_colorPrimary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child: Text(
                                                                  food_lbl_order_online,
                                                                  style: primaryTextStyle(
                                                                      color:
                                                                          white))
                                                              .center(),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 16)

                                                    /* onPressed: _onAddRandomReviewsPressed,*/
                                                  ]),
                                                ])),
                                        Container(
                                          decoration: BoxDecoration(
                                              boxShadow: defaultBoxShadow(),
                                              color: white),
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 16),
                                              Text(
                                                  food_lbl_additional_detail
                                                      .toUpperCase(),
                                                  style: primaryTextStyle()),
                                              SizedBox(height: 20),
                                              iconWithTitle(
                                                      Icons.call, _resto.numero)
                                                  .paddingOnly(
                                                      top: 4, bottom: 4),
                                              Divider(
                                                  height: 0.5,
                                                  color: food_view_color),
                                              iconWithTitle(Icons.location_on,
                                                      _resto.formatted_address)
                                                  .paddingOnly(
                                                      top: 4, bottom: 4),
                                              Divider(
                                                  height: 0.5,
                                                  color: food_view_color),
                                              iconWithTitle(Icons.web_sharp,
                                                      _resto.siteweb)
                                                  .paddingOnly(
                                                      top: 4, bottom: 4),
                                              Divider(
                                                  height: 0.5,
                                                  color: food_view_color),
                                              iconWithTitle(Icons.watch_later,
                                                      _resto.horaire)
                                                  .paddingOnly(
                                                      top: 4, bottom: 4),
                                              SizedBox(height: 16),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        food_color_light_orange),
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  children: <Widget>[
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          WidgetSpan(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: 8),
                                                              child: Icon(
                                                                  Icons
                                                                      .shopping_basket,
                                                                  color:
                                                                      food_color_Orange,
                                                                  size: 18),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                              text:
                                                                  food_lbl_15_off,
                                                              style: primaryTextStyle(
                                                                  size: 16,
                                                                  color:
                                                                      food_color_Orange)),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                        food_lbl_on_total_bill_till_may_2020,
                                                        style:
                                                            primaryTextStyle())
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ])))
                        ])));
  }
}

class RestoPageArguments {
  final String restoId;

  RestoPageArguments({@required this.restoId});
}
*/
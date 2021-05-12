import 'dart:async';
import 'dart:math';
import 'package:app_food/food/model/filter.dart';
import 'package:app_food/food/model/resto.dart';
import 'package:app_food/food/utils/FoodColors.dart';
import 'package:app_food/food/widgets/dialogs/filter_select.dart';
import 'package:app_food/food/widgets/empty_list.dart';
import 'package:app_food/food/widgets/filter_bar.dart';
import 'package:app_food/food/widgets/grid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_food/food/model/data.dart'as data;
import 'package:flutter/material.dart';
import 'FoodViewRestaurants.dart';
//lsite des restos

class HomePage extends StatefulWidget {
  static const route = '/';
  SearchBar searchBar;
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _HomePageState() {
    FirebaseAuth.instance
        .signInAnonymously()
        .then((UserCredential userCredential) {
      _currentSubscription =
          data.loadAllrestos().listen(_updateRestaurants);
    });
  }

  @override
  void dispose() {
    _currentSubscription?.cancel();
    super.dispose();
  }

  StreamSubscription<QuerySnapshot> _currentSubscription;
  bool _isLoading = true;
  List<Resto> _restos = <Resto>[];
  Filter _filter;

  void _updateRestaurants(QuerySnapshot snapshot) {
    setState(() {
      _isLoading = false;
      _restos = data.getrestosFromQuery(snapshot);
    });
  }

  Future<void> _onAddRandomRestoPressed() async {
    final numReviews = Random().nextInt(10) + 20;

    final restos= List.generate(numReviews, (_) => Resto.random());
  /*  data.addrestosBatch(restos);*/
  }

  Future<void> _onFilterBarPressed() async {
    final filter = await showDialog<Filter>(
      context: context,
      builder: (_) => FilterSelectDialog(filter: _filter),
    );
    if (filter != null) {
      await _currentSubscription?.cancel();
      setState(() {
        _isLoading = true;
        _filter = filter;
        if (filter.isDefault) {
          _currentSubscription =
              data.loadAllrestos().listen(_updateRestaurants);
        } else {
          _currentSubscription =
              data.loadFilteredrestos(filter).listen(_updateRestaurants);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: food_white,
          leading: Icon(Icons.restaurant),
          title: Text('Entrez votre recherche',style: TextStyle(color: Color(0xff238c00))),

          bottom: PreferredSize(
            preferredSize: Size(420, 48),
            child: Padding(
              padding: EdgeInsets.fromLTRB(1, 6, 6, 4),
              child: FilterBar(
                filter: _filter,
                onPressed: _onFilterBarPressed,
              ),

            ),
          ),

        ),
        body: SafeArea (

          child: Container(


            constraints: BoxConstraints(maxWidth: 1280),
            child: _isLoading
                ? CircularProgressIndicator()
                : _restos.isNotEmpty
                ? RestoGrid(
                restos: _restos,
                onRestoPressed: (restoId) {
                  // TODO: Add deep links on web
                  Navigator.pushNamed(context, RestoPage.route,
                      arguments: RestoPageArguments(restoId: restoId));
                })
             : EmptyListView(
              child: Text('Listo Resto has no restaurants yet!'),
              onPressed: _onAddRandomRestoPressed,
            ),
          )
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:math';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:app_food/food/model/filter.dart';
import 'package:app_food/food/model/resto.dart';
import 'package:app_food/food/utils/FoodColors.dart';
import 'package:app_food/food/widgets/dialogs/filter_select.dart';
import 'package:app_food/food/widgets/empty_list.dart';
import 'package:app_food/food/widgets/filter_bar.dart';
import 'package:app_food/food/widgets/grid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_food/food/model/data.dart'as data;
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../main.dart';
import 'FoodDashboard.dart';
import 'FoodViewRestaurants.dart';
//lsite des restos

class HomePage extends StatefulWidget {
  static const route = '/';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FocusNode focusNode = FocusNode();
  final _controller = TextEditingController();
  TextEditingController textController = TextEditingController();

  bool _isSearching = false;
  Widget appBarTitle = Text("Listo Resto",
      style: TextStyle(color: Color(0xff238c00)));

  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
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
    _controller.dispose();
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
    Widget leadingWidget() {
      return BackButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) =>
                      FoodDashboard()));
        },
      );
    }
    return SafeArea(

      child: Scaffold(

        appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: appBarTitle),
            ),
            leading: leadingWidget(),
          actions: [
            IconButton(
              icon: Icon(actionIcon.icon,
                  color: appStore.textPrimaryColor),
              onPressed: () {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(Icons.close,
                      color: appStore.textPrimaryColor);
                  this.appBarTitle = TextField(
                    focusNode: focusNode,
                    onChanged: (value) {
                      setState(() {});
                    },
                    style: TextStyle(
                        color: appStore.textPrimaryColor, fontSize: 20),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search,
                          color: appStore.textPrimaryColor),
                      hintText: "Rechercher restaurants",
                      hintStyle: TextStyle(
                          color: appStore.textPrimaryColor,
                          fontWeight: FontWeight.normal),
                    ),
                  );
                  setState(() {
                    _isSearching = true;
                  });
                } else {
                  setState(() {
                    this.actionIcon = Icon(Icons.search,
                        color: appStore.textPrimaryColor);
                    this.appBarTitle = Text("Listo Resto",
                        style: TextStyle(color: Color(0xff238c00)));
                    _isSearching = false;
                  });
                }
                FocusScope.of(context).requestFocus(focusNode);
              },
            ),
          ],
          backgroundColor: food_white,
        /*  leading: Icon(Icons.restaurant),

          title: Text('Entrez votre recherche',style: TextStyle(color: Color(0xff238c00))),*/

          bottom: PreferredSize(
            preferredSize: Size(420, 40),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 2, 1, 0),
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

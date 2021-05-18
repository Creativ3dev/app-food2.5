import 'package:app_food/food/screen/home_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:app_food/food/model/FoodModel.dart';
import 'package:app_food/food/utils/FoodColors.dart';
import 'package:app_food/food/utils/FoodDataGenerator.dart';
import 'package:app_food/food/utils/FoodImages.dart';
import 'package:app_food/food/utils/FoodString.dart';
import 'package:app_food/food/utils/FoodWidget.dart';
import 'package:app_food/main/utils/AppWidget.dart';
import 'FoodAddAddress.dart';
import 'FoodBookCart.dart';
import 'FoodDescription.dart';
import 'FoodFavourite.dart';
import 'FoodOrder.dart';
import 'FoodProfile.dart';
import 'FoodSignIn.dart';
import 'FoodViewRestaurants.dart';
import 'authentification.dart';

//page d'acceuil
class FoodDashboard extends StatefulWidget {
  static String tag = '/FoodDashboard';

  @override
  FoodDashboardState createState() => FoodDashboardState();
}

class FoodDashboardState extends State<FoodDashboard> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
// donnee statique
  List<DashboardCollections> mCollectionList;

  List<Restaurants> mBakeryList;
  List<Restaurants> mDeliveryList;
  List<Restaurants> mDineOutList;
  List<DashboardCollections> mExperienceList;
  List<Restaurants> mCafeList;

  @override
  void initState() {
    super.initState();
    mCollectionList = addCollectionData();
    mBakeryList = addBakeryData();
    mDeliveryList = addDeliveryRestaurantsData();
    mDineOutList = addDineOutRestaurantsData();
    mExperienceList = addCuisineData();
    mCafeList = addCafeData();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(white);
    Widget topGradient(var gradientColor1, var gradientColor2, var icon,
        var heading, var subHeading) {
      var width = MediaQuery.of(context).size.width;
      return GestureDetector(
        onTap: () {
          RestoPage().launch(context);
        },
        child: Container(
          /* decoration: gradientBoxDecoration(showShadow: true, gradientColor1: gradientColor1, gradientColor2: gradientColor2),
          padding: EdgeInsets.all(10),*/
          child: (Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            /*  children: <Widget>[
             /* SvgPicture.asset(icon, color: food_white, width: width * 0.06, height: width * 10),*/
              Text(heading, style: primaryTextStyle(color: food_white)),
              Text(subHeading, style: primaryTextStyle(color: food_white, size: 12),),
            ],*/
          )),
        ),
      );
    }

    return Scaffold(
      backgroundColor: food_app_background,
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: food_white,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),

                  Text(food_app_name, style: boldTextStyle(size: 18)),
                  /*IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      FoodBookCart().launch(context);
                    },
                  ),*/ //
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/food/acceuil.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 366),
                          mAddress(context),
                          SizedBox(height: 16),
                          search(context),
                          SizedBox(height: 16),
                          SizedBox(
                              width: 300,
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.arrow_forward_ios_outlined,
                                    size: 20),
                                label: Text(
                                  '  restaurant',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.lightBlueAccent),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(height: 300),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      drawer: FoodSideMenu(),
    );
  }
}

class Item extends StatelessWidget {
  Restaurants model;

  Item(Restaurants model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FoodDescription().launch(context);
      },
      child: Container(
        width: width * 0.4,
        margin: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(boxShadow: defaultBoxShadow(), color: white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    placeholder: placeholderWidgetFn(),
                    imageUrl: model.image,
                    height: width * 0.3,
                    width: width * 0.4,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.favorite_border,
                        color: food_white, size: 18),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model.name, style: primaryTextStyle(), maxLines: 2),
                  4.height,
                  Row(
                    children: <Widget>[
                      mRating(model.rating.toString()),
                      Text(
                        model.review,
                        style: primaryTextStyle(
                            color: food_textColorSecondary, size: 14),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Collection extends StatelessWidget {
  DashboardCollections model;

  Collection(DashboardCollections model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        /* FoodViewRestaurants().launch(context);*/
      },
      child: Container(
        margin: EdgeInsets.only(left: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                placeholder: placeholderWidgetFn(),
                imageUrl: model.image,
                width: width * 0.5,
                height: 250,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model.name,
                      style: primaryTextStyle(
                          size: 20, fontFamily: 'Andina', color: white)),
                  SizedBox(height: 4),
                  Text(model.info,
                      style: primaryTextStyle(size: 14, color: food_white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//menu
class FoodSideMenu extends StatefulWidget {
  @override
  FoodSideMenuState createState() => FoodSideMenuState();
}

class FoodSideMenuState extends State<FoodSideMenu> {
  Future<void> signOut() async {
    await Authentification().signOut();
  }

  Widget mOption(
      var gradientColor1, var gradientColor2, var icon, var value, var tags) {
    return GestureDetector(
      onTap: () {
        finish(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => tags));
//         launchScreen(context, tags);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [gradientColor1, gradientColor2]),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(icon, size: 18, color: food_white),
              ),
            ),
            SizedBox(width: 16),
            Text(
              value,
              style: primaryTextStyle(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var mView = Container(
        width: MediaQuery.of(context).size.width,
        height: 0.5,
        color: food_view_color);

    return SafeArea(
      child: SizedBox(
        width: width * 0.85,
        height: MediaQuery.of(context).size.height,
        child: Drawer(
          elevation: 8,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  width: width,
                  decoration: gradientBoxDecoration(
                      gradientColor1: food_colorPrimary,
                      gradientColor2: food_colorPrimary,
                      radius: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(food_ic_user1),
                          radius: 40),
                      Text(food_username,
                          style: primaryTextStyle(color: food_white)),
                      Text(food_user_email,
                          style: primaryTextStyle(color: white))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 24, 16),
                  child: Column(
                    children: <Widget>[
                      mOption(
                          food_color_blue_gradient1,
                          food_color_blue_gradient2,
                          Icons.favorite_border,
                          food_lbl_favourite,
                          FoodFavourite()),
                      /*   mOption(food_color_orange_gradient1, food_color_orange_gradient2, Icons.add, food_lbl_add_address, FoodAddAddress()),
                      mOption(food_color_yellow_gradient1, food_color_yellow_gradient2, Icons.insert_drive_file, food_lbl_orders, FoodOrder()),*/
                      mOption(
                          food_color_blue_gradient1,
                          food_color_blue_gradient2,
                          Icons.person_outline,
                          food_lbl_profile,
                          FoodProfile()),
                      ElevatedButton(
                        onPressed: signOut,
                        child: Text("Log out"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text("resto"),
                      ),
                    ],
                  ),
                ),
                mView,
                Container(
                  width: width,
                  padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(food_lbl_quick_searches, style: primaryTextStyle()),
                      Text(food_lbl_cafe,
                          style:
                              primaryTextStyle(color: food_textColorSecondary)),
                      Text(food_hint_search_restaurants,
                          style:
                              primaryTextStyle(color: food_textColorSecondary)),
                      Text(food_lbl_bars,
                          style:
                              primaryTextStyle(color: food_textColorSecondary)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

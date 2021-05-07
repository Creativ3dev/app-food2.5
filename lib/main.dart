
import 'dart:async';

import 'package:app_food/food/model/resto.dart';
import 'package:app_food/food/screen/FoodReview.dart';
import 'package:app_food/main/store/AppStore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'food/screen/FoodDashboard.dart';
import 'food/screen/FoodViewRestaurants.dart';
import 'food/screen/FoodWalkThrough.dart';
import 'food/screen/authentification.dart';
import 'food/widgets/Widget_tree.dart';
import 'main/utils/AppTheme.dart';

AppStore appStore =AppStore();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(value: FirebaseAuth.instance.authStateChanges()),
      ],
      child: MaterialApp(
      title: 'listo resto',
        home: WidgetTree(),
      theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RestoPage.route:
            final RestoPageArguments arguments = settings.arguments;
            return MaterialPageRoute(
                builder: (context) => RestoPage(
                  restoId: arguments.restoId,
                ));
            break;
          default:
          // return MaterialPageRoute(
          //     builder: (context) => RestaurantPage(
          //           restaurantId: 'lV81npEeboEActMpUJjn',
          //         ));
          // Everything defaults to home, but maybe we want a custom 404 here
            return MaterialPageRoute(builder: (context) => SplashScreen());
        }
      },
    )
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> signOut() async {
    await Authentification().signOut();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => FoodWalkThrough()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Image.asset(
              'images/food/food_ic_intro.jpg',
              height: 120,
            ),
            SizedBox(
              height: 50,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

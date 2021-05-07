import 'package:app_food/food/model/FoodModel.dart';
import 'package:app_food/food/screen/FoodDashboard.dart';
import 'package:app_food/food/screen/FoodSignIn.dart';
import 'package:app_food/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class WidgetTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) {
      return FoodSignIn();
    }
    return FoodDashboard();
  }

}
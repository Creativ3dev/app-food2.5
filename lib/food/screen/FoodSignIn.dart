import 'package:app_food/food/screen/FoodDashboard.dart';
import 'package:app_food/food/screen/FoodViewRestaurants.dart';
import 'package:app_food/food/screen/home_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:app_food/food/utils/FoodColors.dart';
import 'package:app_food/food/utils/FoodImages.dart';
import 'package:app_food/food/utils/FoodString.dart';
import 'package:app_food/main/utils/AppWidget.dart';
import 'package:app_food/food/services/loginservice.dart';
import 'package:provider/provider.dart';
import 'package:app_food/food/services/auth_service.dart';

import 'FoodCreateAccount.dart';
import 'authentification.dart';

class FoodSignIn extends StatefulWidget {

  static String tag = '/FoodSignIn';

  @override
  FoodSignInState createState() => FoodSignInState();
}

class FoodSignInState extends State<FoodSignIn> {

  String _email, _password;
  final auth = FirebaseAuth.instance;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  Future<void> signInWithGoogle() async {
    await Authentification().signInWithGoogle();
  }
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {

    changeStatusColor(Colors.transparent);

    var width = MediaQuery.of(context).size.width;
    Widget mOption(var color, var icon, var value, var iconColor, valueColor) {
      return InkWell(
        onTap: () {
          HomePage().launch(context);
        },
        child: Container(
          width: width,
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(50)),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: SvgPicture.asset(icon,
                        color: iconColor, width: 18, height: 18),
                  ),
                ),
                TextSpan(
                    text: value,
                    style: primaryTextStyle(size: 15, color: valueColor)),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CachedNetworkImage(
            placeholder: placeholderWidgetFn(),
            imageUrl: food_ic_login,
            height: width * 0.6,
            fit: BoxFit.cover,
            width: width,
          ),
          Container(
            margin: EdgeInsets.only(top: width * 0.5),
            child: Center(
              child: Stack(
                children: <Widget>[
                  Arc(
                    arcType: ArcType.CONVEX,
                    edge: Edge.TOP,
                    height: (MediaQuery.of(context).size.width) / 10,
                    child: Container(
                        height: (MediaQuery.of(context).size.height),
                        width: MediaQuery.of(context).size.width,
                        color: food_color_green),
                  ),
                  Align(
                    alignment: Alignment.topCenter,

                  ),
                  SizedBox(height: width * 0.4),
                  Padding(
                    padding: const EdgeInsets.only(left: 120,top: 3),
                    child: Text(food_app_name,
                        textAlign: TextAlign.center,
                        style: boldTextStyle(color: food_white, size: 30)),
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.all(26),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(hintText: 'Email'),
                              onChanged: (value) {
                                setState(() {
                                  _email = value.trim();
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(hintText: 'Password'),
                              onChanged: (value) {
                                setState(() {
                                  _password = value.trim();
                                });
                              },
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    child: Text('Se connecter'),

                                    style: TextButton.styleFrom(
                                        primary: Colors.redAccent,
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,)
                                    ),
                                    onPressed: () {
                                      auth
                                          .signInWithEmailAndPassword(
                                          email: _email, password: _password)
                                          .then((_) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FoodDashboard()));
                                      });
                                    }),
                                TextButton(
                                  child: Text("S'inscrire"),
                                  style: TextButton.styleFrom(
                                      primary: Colors.redAccent,
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,)
                                  ),
                                  onPressed: () {
                                    {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FoodCreateAccount()));

                                    };
                                  },
                                ),

                              ]),
                          /*  SizedBox(
                          width: 360,
                          child: TextFormField(
                            validator: (input) {
                              if(input.isEmpty) {
                                return 'Please type an email';
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Email'
                            ),
                            controller: emailTextController,
                          ),
                        ),
                        SizedBox(
                          width: 360,
                          child: TextFormField(
                            obscureText: true,
                            validator: (input) {
                              if(input.isEmpty) {
                                return 'Please type an password';
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Password'
                            ),
                            controller: passwordTextController,
                          ),
                        ),*/


                          SizedBox(height: width * 0.20),

                          SizedBox(
                              width: 300,
                              child:ElevatedButton.icon(
                                icon: Icon(
                                    Icons.toys_outlined,
                                    size:20),
                                label: Text(
                                  '  Sign up with Google',
                                  style: TextStyle(fontSize: 20),
                                ),
                                  onPressed: () async{
                                  /*
                                 signInWithGoogle();*

                                   */
                                    await authClass.googleSignIn(context);

                                },

                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),

                                    ),
                                  ),
                                ),
                              )
                          ),
                          SizedBox(
                              width: 300,
                              child:ElevatedButton.icon(
                                icon: Icon(
                                    Icons.thumb_up,
                                    size:20),
                                label: Text(
                                  '  Sign up with Facebook',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: ()async {

                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),

                                    ),
                                  ),
                                ),
                              )
                          ),
                          SizedBox(
                              width: 300,
                              child:ElevatedButton.icon(
                                icon: Icon(
                                    Icons.airplay,
                                    size:20),
                                label: Text(
                                  '  Sign up with Apple',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: ()async {

                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),

                                    ),
                                  ),
                                ),
                              )
                          ),
                          SizedBox(
                              width: 300,
                              child:ElevatedButton.icon(
                                icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size:20),
                                label: Text(
                                  '  restaurant',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomePage()));     },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),

                                    ),
                                  ),
                                ),
                              )
                          ),
                          SizedBox(height: width * 0.01),
                          SizedBox(
                              width: 300,
                              child:ElevatedButton.icon(
                                icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size:20),
                                label: Text(
                                  '  Sans inscription',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FoodDashboard()));     },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),

                                    ),
                                  ),
                                ),
                              )
                          ),
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}

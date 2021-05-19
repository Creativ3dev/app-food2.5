import 'package:app_food/food/screen/FoodSignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_food/food/utils/FoodColors.dart';
import 'package:app_food/main/utils/AppWidget.dart';

// page creation de  compte
class FoodCreateAccount extends StatefulWidget {
  static String tag = '/FoodCreateAccount';

  @override
  FoodCreateAccountState createState() => FoodCreateAccountState();
}

class FoodCreateAccountState extends State<FoodCreateAccount> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    changeStatusColor(food_white);

    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: food_color_green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 360,
              child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type an email';
                  }
                },
                decoration: InputDecoration(labelText: 'Email'),
                controller: emailTextController,
              ),
            ),
            SizedBox(
              width: 360,
              child: TextFormField(
                obscureText: true,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type an password';
                  }
                },
                decoration: InputDecoration(labelText: 'Password'),
                controller: passwordTextController,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton.icon(
                icon: Icon(Icons.mail, size: 20),
                label: Text(
                  '  Sign up with Mail',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => FoodSignIn()));
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 20),

            /* onPressed: () {
                  signUpWithFacebook();
                },*/

            TextButton(
              child: Text("Se connnecter"),
              style: TextButton.styleFrom(
                  primary: Colors.redAccent,
                  textStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  )),
              onPressed: () {
                {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => FoodSignIn()));
                }
                ;
              },
            )
          ],
        ),
      ),
    );
  }

/* test de connexion avec googgle
 Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) => print('registered'));
  }
*/
/* Avec Facebook
  Future<void> signUpWithFacebook() async{
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);
      if(result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );
        final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print('signed in ' + user.displayName);
        return user;
      }
    }catch (e) {
      print(e.message);
    }
  }
*/
  //connexion avec Adresse email
  Future<void> signUpWithMail() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Success sign up'),
            );
          });
    } catch (e) {
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          });
    }
  }
/* test de connexion avec googgle
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
*/

}

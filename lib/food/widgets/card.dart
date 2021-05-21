
/*import 'package:app_food/food/model/resto.dart';
import 'package:app_food/food/utils/FoodColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

//affichage de la liste des restaurants
class RestoCard extends StatelessWidget {
  RestoCard({
    this.resto,
    @required RestoPressedCallback onRestoPressed,
  }) : _onPressed = onRestoPressed;

  final Resto resto;

  final RestoPressedCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Card(
          child: InkWell(
        onTap: () => _onPressed(resto.id),
        splashColor: Colors.red.withAlpha(30),
        child: Container(
          height: 320,
          child: Column(
            children: <Widget>[
              // TODO: Make this a Hero widget so we can transition to it?
              Expanded(
                child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(resto.photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: null),
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              resto.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 120),
                              child: Text('verifié'),
                            ),
                          ),
                          Icon(
                            Icons.verified_user,
                            color: Colors.green,
                            size: 20.0,
                            semanticLabel: 'text',
                          ),
                        ],
                      ),
                      Container(
                        child: Text(
                          '${resto.ville}',
                          style:
                              primaryTextStyle(color: food_textColorSecondary),
                        ),
                      ),
                      Container(
                          child: Row(
                        children: [
                          Text(
                            ('700m'),
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
*/
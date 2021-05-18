// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:app_food/food/model/resto.dart';
import 'package:app_food/food/screen/FoodDescription.dart';
import 'package:app_food/food/utils/FoodColors.dart';
import 'package:app_food/food/utils/FoodString.dart';
import 'package:app_food/food/utils/FoodWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'stars.dart';

//app bar details resto (image +close)
class RestoAppBar extends StatelessWidget {
  static final double appBarHeight = 160;

  RestoAppBar({
    this.resto,
    CloserestoPressedCallback onClosePressed,
  }) : _onPressed = onClosePressed;

  final Resto resto;

  final CloserestoPressedCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    double expandHeight = MediaQuery.of(context).size.height * 0.33;
    var width = MediaQuery.of(context).size.width;
    var mTime = 0;

    return SliverAppBar(
      leading: IconButton(
        onPressed: _onPressed,
        icon: Icon(
          Icons.close,
          color: Colors.yellow,
        ),
        iconSize: 32,
      ),
      expandedHeight: appBarHeight,
      forceElevated: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Wrap(
          children: <Widget>[
            /* Text(
                resto.name,
                overflow: TextOverflow.ellipsis,
              ),*/
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 80,
                  alignment: Alignment.bottomLeft,
                  /* child: StarRating(
                      rating: resto.rating,
                      color: Colors.white,
                      size: 16,
                    ),*/
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6),
                  /* child: Text(
                       resto.name,
                      style: TextStyle(
                          fontSize: Theme.of(context).textTheme.caption.fontSize),
                    ),*/
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 2),
              /* child: Text(
                  '${resto.categorie} ● ${resto.coumpound}',
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.caption.fontSize),
                ),*/
            ),
          ],
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              resto.photo,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFFFF),
                    const Color(0xFFFFFF),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

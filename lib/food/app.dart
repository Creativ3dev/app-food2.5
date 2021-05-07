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

import 'package:app_food/food/screen/FoodDashboard.dart';
import 'package:app_food/food/screen/FoodViewRestaurants.dart';
import 'package:app_food/food/screen/home_page.dart';
import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'listo resto',
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
            return MaterialPageRoute(builder: (context) => FoodDashboard());
        }
      },
    );
  }
}

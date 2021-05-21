/*
import 'package:app_food/food/model/resto.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:responsive_grid/responsive_grid.dart';

import 'card.dart';
//fait la transition entre la liste des restos et les details d'un restaurant

const double _minSpacingPx = 16;
const double _cardWidth = 350;

class RestoGrid extends StatelessWidget {
  RestoGrid({
    @required RestoPressedCallback onRestoPressed,
    @required List<Resto> restos,
  })  : _onRestoPressed = onRestoPressed,
        _restos = restos;

  final RestoPressedCallback _onRestoPressed;
  final List<Resto> _restos;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      // ResponsiveGridList crashes if desiredItemWidth + 2*minSpacing > Device window on Android
      desiredItemWidth: math.min(
          _cardWidth, MediaQuery.of(context).size.width - (2 * _minSpacingPx)),
      minSpacing: _minSpacingPx,
      children: _restos
          .map((resto) => RestoCard(
                resto: resto,
                onRestoPressed: _onRestoPressed,
              ))
          .toList(),
    );
  }
}
*/
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

import 'package:app_food/food/utils/FoodColors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/filter.dart';

const _boldStyle = TextStyle(fontWeight: FontWeight.bold);

class FilterBar extends StatelessWidget {
  FilterBar({@required VoidCallback onPressed, Filter filter})
      : _onPressed = onPressed,
        _filter = filter;

  final VoidCallback _onPressed;
  final Filter _filter;

  List<InlineSpan> _buildCategorySpans(Filter filter) {
    final noneSelected =
        filter == null || filter.isDefault || filter.formatted_address== null;
    return [
      if (noneSelected) TextSpan(text: 'Tout les restaurants ', style: _boldStyle),
      if (!noneSelected) ...[
        TextSpan(text: '${filter.formatted_address}', style: _boldStyle),
        TextSpan(text: ' name'),
      ],
    ];
  }
/*List<InlineSpan>_buildCodeDropdown(Filter filter) {
  return [
    if (filter.coumpound!= null) ...[
      TextSpan(text: ' of '),
      TextSpan(text: filter.coumpound, style: _boldStyle),
    ],
  ];
}

 */

  List<InlineSpan> _buildPriceSpans(Filter filter) {
    return [
      if (filter.formatted_address!= null) ...[
        TextSpan(text: ' of '),
        TextSpan(text: filter.formatted_address, style: _boldStyle),
      ],
    ];
  }

  List<InlineSpan> _buildTitleSpans(Filter filter) {
    return [
      ..._buildCategorySpans(filter),
      if (filter != null && !filter.isDefault) ..._buildPriceSpans(filter),
    ];
  }

  List<InlineSpan> _buildCitySpans(Filter filter) {
    return [
      if (filter.formatted_address != null) ...[
        TextSpan(text: 'in '),
        TextSpan(text: '${filter.formatted_address} ', style: _boldStyle),
      ],
    ];
  }

  List<InlineSpan> _buildSubtitleSpans(Filter filter) {
    final orderedByRating =
        filter == null || filter.categorie == null || filter.categorie == 'categorie';
    return [
      if (filter != null) ..._buildCitySpans(filter),
      if (orderedByRating) TextSpan(text: 'by categorie'),
      if (!orderedByRating) TextSpan(text: 'by # reviews'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    
  /*  IconButton(
      icon: Icon(Icons.search, color: Colors.white),
      onPressed: () {},
    );*/
    return TextButton(
        onPressed: _onPressed,
      child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: food_white),
      padding: EdgeInsets.all(6),
        child: Row(
        children: [
          Icon(Icons.filter_list),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                     children: _buildTitleSpans(_filter),
                    ),
                  ),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.caption,
                      children: _buildSubtitleSpans(_filter),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      )
    );
  }
}

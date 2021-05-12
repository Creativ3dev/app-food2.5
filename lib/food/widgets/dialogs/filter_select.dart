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

import 'package:app_food/food/model/values.dart' as hardcoded;
import 'package:app_food/food/model/filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class FilterSelectDialog extends StatefulWidget {
  FilterSelectDialog({Key key, Filter filter})
      : _filter = filter,
        super(key: key);

  final Filter _filter;

  @override
  _FilterSelectDialogState createState() =>
      _FilterSelectDialogState(filter: _filter);
}

class _FilterSelectDialogState extends State<FilterSelectDialog> {
  _FilterSelectDialogState({Filter filter}) {
    if (filter != null && !filter.isDefault) {
     _type = filter.type;
      _ville = filter.ville;
     /* _compound_code = filter.compound_code*/
      _name = filter.name;
     coumpound = filter.coumpound;

    }
  }

  String _type;
  String _ville;
  String coumpound;
  String _compound_code;
  String _name;

  Widget _buildDropdown<T>(
    List labels,
    List values,
    dynamic selected,
    FilterChangedCallback<T> onChanged,
  ) {
    final items = [
      for (var i = 0; i < values.length; i++)
        DropdownMenuItem<T>(value: values[i], child: Text(labels[i])),
    ];
    return DropdownButton<T>(
      items: items,
      isExpanded: true,
      value: selected,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownRow<T>({
    List<T> values,
    List<String> labels,
    T selected,
    IconData icon,
    FilterChangedCallback<T> onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(icon),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
            child: _buildDropdown<T>(labels, values, selected, onChanged),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown({
    String selected,
    FilterChangedCallback<String> onChanged,
  }) {
    return _buildDropdownRow<String>(
      labels: ['Any Cuisine', ...hardcoded.type],
      values: [null, ...hardcoded.type],
      selected: selected,
      icon: Icons.fastfood,
      onChanged: onChanged,
    );
  }

  Widget _buildCityDropdown({
    String selected,
    FilterChangedCallback<String> onChanged,
  }) {
    return _buildDropdownRow<String>(
      labels: ['Any Location', ...hardcoded.ville],
      values: [null, ...hardcoded. ville],
      selected: selected,
      icon: Icons.location_on,
      onChanged: onChanged,
    );
  }



  Widget _buildCodeDropdown({
    String selected,
    FilterChangedCallback<String> onChanged,
  }) {
    return _buildDropdownRow<String>(
      labels: ['rating', 'type'],
      values: ['rating', 'type'],
      selected: selected,
      icon: Icons.sort,
      onChanged: onChanged,
    );
  }

  Widget _buildSortDropdown({
    String selected,
    FilterChangedCallback<String> onChanged,
  }) {
    return _buildDropdownRow<String>(
      labels: ['rating', 'type'],
      values: ['rating', 'type'],
      selected: selected,
      icon: Icons.sort,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.filter_list,color: Colors.green,),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
            child: Text('Filter'),
          ),
        ],
      ),
      content: Container(
        width: math.min(MediaQuery.of(context).size.width, 740),
        height: math.min(MediaQuery.of(context).size.height, 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCategoryDropdown(
                selected: _type,
                onChanged: (String value) {
                  setState(() {
                    _type = value;
                  });
                }),
            _buildCityDropdown(
                selected: _ville,
                onChanged: (String value) {
                  setState(() {
                    _ville = value;
                  });
                }),
            _buildCodeDropdown(
                selected: _type,
                onChanged: (String value) {
                  setState(() {
                    _type= value;
                  });
                }),

        /*    _buildSortDropdown(
                selected: _rating ?? 'rating',
                onChanged: (String value) {
                  setState(() {
                    _rat= value;
                  });
                }),*/
          ],
        ),
      ),
      actions: [
        FlatButton(
          child: Text('CLEAR ALL'),
          onPressed: () => Navigator.pop(context, Filter()),
        ),
        RaisedButton(
          child: Text('ACCEPT'),
          onPressed: () => Navigator.pop(
              context,
              Filter(
                type: _type,
                ville: _ville,
                coumpound: coumpound,
              )),
        ),
      ],
    );
  }
}

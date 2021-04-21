import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonTypesWidget extends StatelessWidget {
  PokemonTypesWidget({this.types});

  final List types;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildTypesList(),
      ),
    );
  }

  _buildTypesList() {
    List<Widget> typesList = [];

    for (var i = 0; i < types.length; i++) {
      typesList.add(
        Container(
          width: 150.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: Pokemon.colorsTemplate[types[i].runtimeType == String
                ? types[i]
                : types[i]['type']['name']],
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Center(
            child: Text(
              types[i].runtimeType == String
                  ? types[i]
                  : types[i]['type']['name'],
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return typesList;
  }
}

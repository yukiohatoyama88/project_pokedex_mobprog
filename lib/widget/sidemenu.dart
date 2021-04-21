import 'package:flutter/material.dart';
import 'package:pokedex/pages/pokedex.dart';
import 'package:pokedex/widget/pokeball_icon_icons.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  ImageProvider logo = AssetImage('assets/img/pokedex.png');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: logo,
                  alignment: Alignment.center,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.red[300],
            ),
          ),
          ListTile(
            leading: Icon(PokeballIcon.pokeball_icon),
            title: Text('Kanto'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokedexPage(pokedexId: 1)),
              );
            },
          ),
          ListTile(
            leading: Icon(PokeballIcon.pokeball_icon),
            title: Text('Johto'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokedexPage(pokedexId: 2)),
              );
            },
          ),
          ListTile(
            leading: Icon(PokeballIcon.pokeball_icon),
            title: Text('Hoenn'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokedexPage(pokedexId: 3)),
              );
            },
          ),
          ListTile(
            leading: Icon(PokeballIcon.pokeball_icon),
            title: Text('Sinnoh'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokedexPage(pokedexId: 4)),
              );
            },
          ),
          ListTile(
            leading: Icon(PokeballIcon.pokeball_icon),
            title: Text('Unova'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokedexPage(pokedexId: 5)),
              );
            },
          ),
          ListTile(
            leading: Icon(PokeballIcon.pokeball_icon),
            title: Text('Kalos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokedexPage(pokedexId: 6)),
              );
            },
          ),
          ListTile(
            leading: Icon(PokeballIcon.pokeball_icon),
            title: Text('Alola'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokedexPage(pokedexId: 7)),
              );
            },
          ),
          ListTile(
            leading: Icon(PokeballIcon.pokeball_icon),
            title: Text('Galar'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokedexPage(pokedexId: 8)),
              );
            },
          )
        ],
      ),
    );
  }
}

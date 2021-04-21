import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pages/loading_pokemon.dart';
import 'package:pokedex/utils/pokemon_list.dart';

class SearchAppBar extends StatefulWidget {
  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  TextEditingController search = TextEditingController();

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red[300],
      leading: isSearching ? _buildSearchLeading() : _buildTitleLeading(),
      title: isSearching ? _buildSearchInput() : _buildTitle(),
      actions: isSearching ? _buildSearchActions() : _buildTitleActions(),
      centerTitle: true,
    );
  }

  _buildSearchLeading() {
    return Icon(
      Icons.search,
      color: Colors.white,
    );
  }

  _buildTitleLeading() {
    return GestureDetector(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: Icon(
        Icons.menu,
        color: Colors.white,
      ),
    );
  }

  List<Widget> _buildSearchActions() {
    return [
      IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            search.text = '';
          });
        },
      ),
      IconButton(
        icon: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            search.text = '';
            isSearching = false;
          });
        },
      ),
    ];
  }

  List<Widget> _buildTitleActions() {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          setState(() {
            isSearching = true;
          });
        },
      ),
    ];
  }

  _buildTitle() {
    return Text(
      'Pokedex',
      style: TextStyle(fontWeight: FontWeight.w700),
    );
  }

  _buildSearchInput() {
    return AutoCompleteTextField<String>(
      key: key,
      controller: search,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        focusColor: Colors.white,
        hoverColor: Colors.white,
        fillColor: Colors.white,
      ),
      itemBuilder: (BuildContext context, String suggestion) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.red[200],
            border: Border.all(
              color: Colors.red[200],
            ),
          ),
          height: 70,
          width: 300,
          child: Center(
            child: Text(
              suggestion,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        );
      },
      itemFilter: (item, query) {
        return item.toLowerCase().startsWith(
              query.toLowerCase(),
            );
      },
      itemSorter: (a, b) {
        return a.compareTo(b);
      },
      itemSubmitted: (data) {
        search.text = data;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoadingPokemonPage(
              pokemonName: search.text.toLowerCase(),
            ),
          ),
        );
      },
      suggestions: pokemonList,
      keyboardType: TextInputType.text,
      clearOnSubmit: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon.dart';
import 'package:pokedex/services/pokedex_service.dart';

class LoadingPokemonPage extends StatefulWidget {
  final String pokemonName;

  const LoadingPokemonPage({
    Key key,
    this.pokemonName,
  }) : super(key: key);
  @override
  _LoadingPokemonPageState createState() => _LoadingPokemonPageState();
}

class _LoadingPokemonPageState extends State<LoadingPokemonPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PokedexService.getPokemon(
        name: widget.pokemonName,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Pokemon pokemon = snapshot.data;

          return PokemonPage(pokemon: pokemon);
        }

        return Scaffold(
          backgroundColor: Colors.grey[850],
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: LinearProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

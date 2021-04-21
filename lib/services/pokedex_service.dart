import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/utils/string_extension.dart';
import 'package:pokedex/models/pokedex.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokedexService {
  static getPokedex(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('pokedex_$id')) {
      String pokedexJson = prefs.getString('pokedex_$id');

      final Pokedex pokedex = Pokedex.fromJson(json.decode(pokedexJson));

      return pokedex;
    }

    try {
      final String url =
          'https://us-central1-image-dominant-color.cloudfunctions.net/getPokedexByGenerationFromPokedexApi';
      final response = await http.post(url, body: {'regionId': id.toString()});

      if (response.statusCode == 200) {
        final Pokedex pokedex = Pokedex.fromJson(json.decode(response.body));

        prefs.setString('pokedex_$id', json.encode(pokedex.toJson()));

        return pokedex;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error getting Pokemon from this Pokedex, try again later!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      if (e is Error) {
        print(e.stackTrace);
        return Error;
      }

      print('Error getPokedex -> $e');
    }
  }

  static getPokemon({String name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('pokemon_$name')) {
      String pokemonJson = prefs.getString('pokemon_$name');

      final Pokemon pokemon = Pokemon.fromJson(json.decode(pokemonJson));

      return pokemon;
    }

    try {
      final String url =
          'https://us-central1-image-dominant-color.cloudfunctions.net/getPokemonFromPokedexApi';
      final response = await http.post(url, body: {'pokemon': name});

      if (response.statusCode == 200) {
        final Pokemon pokemon = Pokemon.fromJson(json.decode(response.body));

        prefs.setString('pokemon_$name', json.encode(pokemon.toJson()));

        return pokemon;
      }
    } catch (e) {
      if (e is Error) {
        Fluttertoast.showToast(
            msg: "Error on getting info about ${name.capitalize()}.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        return Error;
      }

      print('Error getPokemon -> $e');
    }
  }

  static Future<List<List<Pokemon>>> getEvolutionChain({int chainId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('chain_$chainId')) {
      String chainJson = prefs.getString('chain_$chainId');

      final List chainObj = json.decode(chainJson);
      final List<List<Pokemon>> pokemonEvolutions = [];

      int i = 0;
      int j = 0;

      chainObj.forEach((chain) {
        pokemonEvolutions.add([]);
        j = 0;
        chain.forEach((pokemon) {
          pokemonEvolutions[i].add(Pokemon.fromJson(chainObj[i][j]));
          j++;
        });

        i++;
      });

      return pokemonEvolutions;
    }

    try {
      final String url =
          'https://us-central1-image-dominant-color.cloudfunctions.net/getPokemonEvolutionaryChain';
      final response =
          await http.post(url, body: {'chainId': chainId.toString()});
      final List responseBody = List.from(jsonDecode(response.body));
      final List<List<Pokemon>> pokemonEvolutions = [];

      int i = 0;
      int j = 0;

      responseBody.forEach((chain) {
        pokemonEvolutions.add([]);
        j = 0;
        chain.forEach((pokemon) {
          pokemonEvolutions[i].add(Pokemon.fromJson(responseBody[i][j]));
          j++;
        });

        i++;
      });

      prefs.setString('chain_$chainId', json.encode(pokemonEvolutions));

      return pokemonEvolutions;
    } catch (e) {
      if (e is Error) {
        print(e.stackTrace);
        Fluttertoast.showToast(
          msg: "Error on getting info about evolutions.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        return null;
      }
    }

    return null;
  }

  static getPokemonVariations({
    String pokemonVariationName,
    String pokemonSpeciesName,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('pokemon_$pokemonVariationName')) {
      String pokemonJson = prefs.getString('pokemon_$pokemonVariationName');

      final Pokemon pokemon = Pokemon.fromJson(json.decode(pokemonJson));

      return pokemon;
    }

    try {
      final String url =
          'https://us-central1-image-dominant-color.cloudfunctions.net/getPokemonVariations';
      final response = await http.post(url, body: {
        'pokemonVariationName': pokemonVariationName,
        'pokemonSpeciesName': pokemonSpeciesName,
      });

      final Pokemon pokemon = Pokemon.fromJson(json.decode(response.body));

      prefs.setString(
        'pokemon_$pokemonVariationName',
        json.encode(pokemon.toJson()),
      );

      return pokemon;
    } catch (e) {
      if (e is Error) {
        print(e.stackTrace);
        Fluttertoast.showToast(
          msg: "Error on getting info about evolutions.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        return null;
      }
    }

    return null;
  }
}

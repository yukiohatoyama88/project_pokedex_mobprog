import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/models/stat.dart';

part 'pokemon.g.dart';

@JsonSerializable(explicitToJson: true)
class Pokemon {
  const Pokemon({
    this.id,
    this.name,
    this.abilities,
    this.baseExperience,
    this.stats,
    this.types,
    this.rgb,
    this.artwork,
    this.moves,
    this.pokedexFlavorEntry,
    this.evolutionChainId,
    this.isVariation,
    this.varieties,
  });

  final int id;

  final String name;

  final List abilities;

  @JsonKey(name: 'base_experience')
  final int baseExperience;

  final List<Stat> stats;

  final List types;

  final List rgb;

  final String artwork;

  final List moves;

  @JsonKey(name: 'pokedex_flavor_entry')
  final String pokedexFlavorEntry;

  @JsonKey(name: 'evolution_chain_id')
  final int evolutionChainId;

  @JsonKey(name: 'is_variation')
  final bool isVariation;

  final List<Map> varieties;

  static Map colorsTemplate = {
    'bug': Color.fromARGB(255, 198, 209, 110),
    'dark': Color.fromARGB(255, 162, 146, 136),
    'dragon': Color.fromARGB(255, 162, 125, 250),
    'electric': Color.fromARGB(255, 250, 224, 120),
    'fairy': Color.fromARGB(255, 244, 189, 201),
    'fighting': Color.fromARGB(255, 214, 120, 115),
    'fire': Color.fromARGB(255, 245, 172, 120),
    'flying': Color.fromARGB(255, 198, 183, 245),
    'ghost': Color.fromARGB(255, 162, 146, 188),
    'grass': Color.fromARGB(255, 167, 219, 141),
    'ground': Color.fromARGB(255, 235, 214, 157),
    'ice': Color.fromARGB(255, 188, 230, 230),
    'normal': Color.fromARGB(255, 198, 198, 167),
    'poison': Color.fromARGB(255, 193, 131, 193),
    'psychic': Color.fromARGB(255, 250, 146, 178),
    'rock': Color.fromARGB(255, 209, 193, 125),
    'steel': Color.fromARGB(255, 209, 209, 224),
    'water': Color.fromARGB(255, 157, 183, 245),
  };

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

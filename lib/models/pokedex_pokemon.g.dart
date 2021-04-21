// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex_pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokedexPokemon _$PokedexPokemonFromJson(Map<String, dynamic> json) {
  return PokedexPokemon(
    name: json['name'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$PokedexPokemonToJson(PokedexPokemon instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

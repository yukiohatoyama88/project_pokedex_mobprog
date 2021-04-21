// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokedex _$PokedexFromJson(Map<String, dynamic> json) {
  return Pokedex(
    pokemon: (json['pokemon'] as List)
        ?.map((e) => e == null
            ? null
            : PokedexPokemon.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PokedexToJson(Pokedex instance) => <String, dynamic>{
      'pokemon': instance.pokemon?.map((e) => e?.toJson())?.toList(),
    };

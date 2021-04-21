import 'package:json_annotation/json_annotation.dart';

part 'pokedex_pokemon.g.dart';

@JsonSerializable(explicitToJson: true)
class PokedexPokemon {
  const PokedexPokemon({
    this.name,
    this.url
  });

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'url')
  final String url;

  factory PokedexPokemon.fromJson(Map<String, dynamic> json) => _$PokedexPokemonFromJson(json);

  Map<String, dynamic> toJson() => _$PokedexPokemonToJson(this);
}

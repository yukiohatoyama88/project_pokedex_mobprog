import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/models/pokedex_pokemon.dart';

part 'pokedex.g.dart';

@JsonSerializable(explicitToJson: true)
class Pokedex {
  const Pokedex({
    this.pokemon
  });

  final List<PokedexPokemon> pokemon;

  factory Pokedex.fromJson(Map<String, dynamic> json) => _$PokedexFromJson(json);

  Map<String, dynamic> toJson() => _$PokedexToJson(this);
}

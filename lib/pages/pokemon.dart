import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/string_extension.dart';
import 'package:pokedex/widget/pokemon_alternative_forms.dart';
import 'package:pokedex/widget/pokemon_evolution_chain.dart';
import 'package:pokedex/widget/pokemon_stats.dart';
import 'package:pokedex/widget/pokemon_types.dart';

class PokemonPage extends StatefulWidget {
  @override
  _PokemonPageState createState() => _PokemonPageState();

  PokemonPage({Key key, this.pokemon}) : super(key: key);

  final Pokemon pokemon;
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    print('isVariation -> ${widget.pokemon.varieties}');

    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  child: Text(
                    !widget.pokemon.isVariation
                        ? '#' + widget.pokemon.id.toString()
                        : ' ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: EdgeInsets.only(top: statusBarHeight),
                child: Hero(
                  child: Image.network(
                    widget.pokemon.artwork,
                    fit: BoxFit.fitHeight,
                  ),
                  tag: 'pokemon_image_' + widget.pokemon.name,
                ),
              ),
            ),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            expandedHeight: 200.0 + statusBarHeight,
            backgroundColor: widget.pokemon.rgb.length > 0
                ? Color.fromARGB(255, widget.pokemon.rgb[0],
                    widget.pokemon.rgb[1], widget.pokemon.rgb[2])
                : Colors.white,
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(bottom: 5.0, top: 15.0),
              child: Center(
                child: Text(
                  widget.pokemon.name.capitalize(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
              child: Center(
                child: Text(
                  '\"' + widget.pokemon.pokedexFlavorEntry + '\"',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: PokemonTypesWidget(types: widget.pokemon.types),
          ),
          SliverToBoxAdapter(
            child: PokemonStatsWidget(
              stats: widget.pokemon.stats,
              color: Color.fromARGB(255, widget.pokemon.rgb[0],
                  widget.pokemon.rgb[1], widget.pokemon.rgb[2]),
            ),
          ),
          !widget.pokemon.isVariation
              ? SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 5.0, top: 15.0),
                    child: Center(
                      child: Text(
                        'Evolutions',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      ),
                    ),
                  ),
                )
              : SliverToBoxAdapter(child: Container()),
          !widget.pokemon.isVariation
              ? SliverToBoxAdapter(
                  child: EvolutionChainWidget(
                    pokemon: widget.pokemon,
                  ),
                )
              : SliverToBoxAdapter(child: Container()),
          !widget.pokemon.isVariation && widget.pokemon.varieties.length > 0
              ? SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 5.0, top: 15.0),
                    child: Center(
                      child: Text(
                        'Alternative Forms',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      ),
                    ),
                  ),
                )
              : SliverToBoxAdapter(child: Container()),
          !widget.pokemon.isVariation && widget.pokemon.varieties.length > 0
              ? SliverToBoxAdapter(
                  child: PokemonAlternativeFormsWidget(
                    pokemon: widget.pokemon,
                  ),
                )
              : SliverToBoxAdapter(child: Container()),
        ],
      ),
    );
  }
}

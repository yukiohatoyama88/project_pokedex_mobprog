import 'package:flutter/material.dart';
import 'package:pokedex/pages/pokemon.dart';
import 'package:pokedex/utils/string_extension.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonItemWidget extends StatefulWidget {
  @override
  _PokemonItemWidgetState createState() => _PokemonItemWidgetState();

  PokemonItemWidget({
    this.pokemon,
  });

  final Pokemon pokemon;
}

class _PokemonItemWidgetState extends State<PokemonItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonPage(pokemon: widget.pokemon),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.pokemon.rgb.length > 0
              ? Color.fromARGB(
                  255,
                  widget.pokemon.rgb[0],
                  widget.pokemon.rgb[1],
                  widget.pokemon.rgb[2],
                )
              : Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Hero(
                child: Image.network(
                  widget.pokemon.artwork,
                  fit: BoxFit.fitHeight,
                ),
                tag: 'pokemon_image_' + widget.pokemon.name,
              ),
            ),
            Text(
              widget.pokemon.name.capitalize(),
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

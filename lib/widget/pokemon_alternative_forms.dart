import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon.dart';
import 'package:pokedex/services/pokedex_service.dart';

class PokemonAlternativeFormsWidget extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonAlternativeFormsWidget({
    Key key,
    this.pokemon,
  }) : super(key: key);

  @override
  _PokemonAlternativeFormsWidgetState createState() =>
      _PokemonAlternativeFormsWidgetState();
}

class _PokemonAlternativeFormsWidgetState
    extends State<PokemonAlternativeFormsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FutureBuilder(
        future: Future.wait(
          widget.pokemon.varieties.map(
            (el) => PokedexService.getPokemonVariations(
              pokemonSpeciesName: widget.pokemon.name,
              pokemonVariationName: el['name'],
            ),
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List variations = snapshot.data;

            return Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 150,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: variations.length,
                  itemBuilder: (context, index) {
                    print(variations[index].artwork);
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PokemonPage(pokemon: variations[index]),
                        ),
                      ),
                      child: variations[index].artwork != null
                          ? Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(variations[index].artwork),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(),
                    );
                  },
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                width: 100,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[850],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.pokemon.rgb.length > 0
                        ? Color.fromARGB(
                            255,
                            widget.pokemon.rgb[0],
                            widget.pokemon.rgb[1],
                            widget.pokemon.rgb[2],
                          )
                        : Colors.white,
                  ),
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );

    // return Container(
    //   margin: EdgeInsets.symmetric(vertical: 20),
    //   width: double.infinity,
    //   height: 150,
    //   child: Center(
    //     child: ListView.builder(
    //       shrinkWrap: true,
    //       scrollDirection: Axis.horizontal,
    //       itemCount: widget.pokemon.varieties.length,
    //       itemBuilder: (context, index) {
    //         return FutureBuilder(
    //           future: PokedexService.getPokemonVariations(
    //             pokemonSpeciesName: widget.pokemon.name,
    //             pokemonVariationName: widget.pokemon.varieties[index]['name'],
    //           ),
    //           builder: (context, snapshot) {
    //             if (snapshot.connectionState == ConnectionState.done &&
    //                 snapshot.hasData) {
    //               Pokemon pokemon = snapshot.data;

    //               return GestureDetector(
    //                 onTap: () => Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => PokemonPage(pokemon: pokemon),
    //                   ),
    //                 ),
    //                 child: pokemon.artwork != null
    //                     ? Container(
    //                         width: 150,
    //                         height: 150,
    //                         decoration: BoxDecoration(
    //                           image: DecorationImage(
    //                             image: NetworkImage(pokemon.artwork),
    //                             fit: BoxFit.cover,
    //                           ),
    //                         ),
    //                         // child: Image.network(pokemon.artwork),
    //                       )
    //                     : Container(),
    //               );
    //             }

    //             if (snapshot.connectionState == ConnectionState.waiting) {
    //               return Center(
    //                 child: Container(
    //                   margin: EdgeInsets.only(bottom: 20),
    //                   width: 100,
    //                   child: LinearProgressIndicator(
    //                     backgroundColor: Colors.grey[850],
    //                     valueColor: AlwaysStoppedAnimation<Color>(
    //                       widget.pokemon.rgb.length > 0
    //                           ? Color.fromARGB(
    //                               255,
    //                               widget.pokemon.rgb[0],
    //                               widget.pokemon.rgb[1],
    //                               widget.pokemon.rgb[2],
    //                             )
    //                           : Colors.white,
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             }

    //             return Container();
    //           },
    //         );
    //         // return Container();
    //       },
    //     ),
    //   ),
    // );
  }
}

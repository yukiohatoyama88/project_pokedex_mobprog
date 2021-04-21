import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon.dart';
import 'package:pokedex/services/pokedex_service.dart';

class EvolutionChainWidget extends StatefulWidget {
  final Pokemon pokemon;

  const EvolutionChainWidget({
    Key key,
    this.pokemon,
  }) : super(key: key);

  @override
  _EvolutionChainWidgetState createState() => _EvolutionChainWidgetState();
}

class _EvolutionChainWidgetState extends State<EvolutionChainWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PokedexService.getEvolutionChain(
        chainId: widget.pokemon.evolutionChainId,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<List<Pokemon>> chain = snapshot.data;

          return Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _mountChain(chain),
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

        return Icon(Icons.error);
      },
    );
  }

  _mountChain(List<List<Pokemon>> chain) {
    List<Widget> chainList = [];

    int index = 0;

    chain.forEach((evolutionStage) {
      chainList.add(
        Container(
          height: 150,
          width: double.infinity,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: evolutionStage
                  .map(
                    (Pokemon pokemon) => GestureDetector(
                      onTap: () {
                        if (widget.pokemon.name != pokemon.name) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PokemonPage(pokemon: pokemon),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(pokemon.artwork),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // child: Image.network(pokemon.artwork),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );

      if (index != chain.length - 1) {
        chainList.add(
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Transform.rotate(
              angle: pi / 2,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey.shade200,
                size: 30,
              ),
            ),
          ),
        );
      }

      index++;
    });

    return chainList;
  }
}

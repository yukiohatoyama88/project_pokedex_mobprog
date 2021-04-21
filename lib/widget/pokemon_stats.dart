import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class PokemonStatsWidget extends StatelessWidget {
  PokemonStatsWidget({
    this.stats,
    this.color,
  });

  final List stats;

  final Color color;

  final Map statsName = {
    'hp': 'HP',
    'attack': 'Attack',
    'defense': 'Defense',
    'special-attack': 'Sp. Atk',
    'special-defense': 'Sp. Def',
    'speed': 'Speed',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildStatsList(),
      ),
    );
  }

  _buildStatsList() {
    List<Widget> statsList = [];

    for (var i = 0; i < stats.length; i++) {
      statsList.add(Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  statsName[stats[i].stat['name']],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                  child: FAProgressBar(
                currentValue: stats[i].baseStat,
                displayText: '',
                maxValue: 255,
                backgroundColor: Colors.grey[700],
                animatedDuration: Duration(seconds: 1),
                progressColor: color,
              )),
            ],
          )));
    }

    return statsList;
  }
}

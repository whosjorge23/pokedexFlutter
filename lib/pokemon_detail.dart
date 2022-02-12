import 'package:flutter/material.dart';
import './model/pokemon.dart';
import 'dart:ui';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({required this.pokemon});

  final Pokemon pokemon;

  Color pokemonColor(String type) {
    if (type == "fire") {
      return Color(0xffE67D23);
    } else if (type == "poison") {
      return Color(0xFF745EC5);
    } else if (type == "water" || type == "ice") {
      return Color(0xff3399DA);
    } else if (type == "electric") {
      return Color(0xffFFCD00);
    } else if (type == "psychic") {
      return Color(0xff9B58B6);
    } else if (type == "normal") {
      return Color(0xff5D4533);
    } else if (type == "ground" || type == "rock") {
      return Color(0xff95A5A6);
    } else if (type == "flying") {
      return Color(0xff3A7081);
    } else if (type == "fairy") {
      return Color(0xffF47CC3);
    } else if (type == "fighting") {
      return Color(0xFFA28671);
    } else if (type == "steel") {
      return Color(0xFFBDC3C7);
    } else {
      return Color(0xff2fcc71);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 32.0, left: 16.0, right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.network(pokemon.imageUrl),
                  ),
                  Text("\n"),
                  ActionChip(
                      label: Text(pokemon.type,
                          style: TextStyle(color: Colors.white, height: 2)),
                      backgroundColor: pokemonColor(pokemon.type),
                      onPressed: () {}),
                  Text("\n"),
                  Text(pokemon.name.toUpperCase(),
                      style: TextStyle(fontSize: 30)),
                  Text("\n"),
                  Text(pokemon.description, style: TextStyle(fontSize: 15)),
                  Text("\n"),
                  Text("Attack"),
                  Slider(
                    value: pokemon.attack.toDouble(),
                    max: 150,
                    divisions: 150,
                    label: pokemon.attack.round().toString(),
                    onChanged: (double value) {},
                    activeColor: Color(0xFF2fcc71),
                    inactiveColor: Colors.black26,
                    //thumbColor: Color(0xFF2fcc71),
                  ),
                  Text("Defense:"),
                  Slider(
                    value: pokemon.defense.toDouble(),
                    max: 150,
                    divisions: 150,
                    label: pokemon.defense.round().toString(),
                    onChanged: (double value) {},
                    activeColor: Color(0xFFe84c3b),
                    inactiveColor: Colors.black26,
                    //thumbColor: Color(0xFFe84c3b),
                  ),
                ], //Widget[]
              ), //Column
            ),
          ), //Padding
        ), //Card
      ), //SingleChildScrollView
    );
  }
}

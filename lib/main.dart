import 'dart:convert';

import 'package:flutter/material.dart';
import './model/pokemon.dart';
import 'package:http/http.dart' as http;
import 'pokemon_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        scaffoldBackgroundColor: const Color(0xFFecf0f1),
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Pokedex App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Pokemon> _pokemon = <Pokemon>[];

  Future<List<Pokemon>> fetchPokemons() async {
    var url = 'https://whosjorge23.github.io/jsonapi/pokemon2.json';
    var response = await http.get(Uri.parse(url));

    var pokemons = <Pokemon>[];

    if (response.statusCode == 200) {
      var pokemonsJson = json.decode(response.body);
      for (var pokemonsJson in pokemonsJson) {
        pokemons.add(Pokemon.fromJson(pokemonsJson));
      }
    }
    return pokemons;
  }

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
  void initState() {
    fetchPokemons().then((value) {
      setState(() {
        _pokemon.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: Icon(Icons.catching_pokemon_rounded),
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(_pokemon.length, (index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PokemonDetailScreen(pokemon: _pokemon[index]),
                  ),
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(flex: 2),
                    Image.network(_pokemon[index].imageUrl,
                        width: 100, height: 100, fit: BoxFit.fitWidth),
                    Spacer(flex: 1),
                    ActionChip(
                        label: Text(_pokemon[index].type,
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: pokemonColor(_pokemon[index].type),
                        onPressed: () {}),
                    Spacer(flex: 1),
                    Text(
                      _pokemon[index].name.toUpperCase(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

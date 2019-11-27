import 'package:flutter/material.dart';
import 'package:flutter_app/Pokemon.dart';
import 'package:flutter_app/TypePokemon.dart';
import 'package:flutter_app/detail_screen.dart';
import 'package:flutter_app/service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Service _service = Service();
  List<Pokemon> pokemonsOrigin = List();
  List<Pokemon> pokemons = List();
  List<TypePokemon> types = List();

  void _loadPokemonsFromServer() {
    _service.loadPokemons().then((pokemons) {
      setState(() {
        this.pokemonsOrigin = pokemons;
        this.pokemons = pokemons;
      });
    }).catchError((error) {
      print(error);
    });
  }

  void _loadTypes() {
    _service.loadTypes().then((types) {
      setState(() {
        this.types = types;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void initState() {
    _loadTypes();
    _loadPokemonsFromServer();
    super.initState();
  }

  _openDetail(Pokemon pokemon, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(pokemon: pokemon, index: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: types.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      String type = types[index].name;
                      setState(() {
                        pokemons = pokemonsOrigin.where((pokemon) {
                          return pokemon.type.contains(type);
                        }).toList();
                        print("poke: $pokemons");
                      });
                    },
                    child: Image.network(
                      types[index].thumbnailImage,
                      height: 60,
                      width: 60,
                    ),
                  );
                }),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: pokemons.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        onTap: () => _openDetail(pokemons[index], index),
                        leading: Hero(
                          tag: '${pokemons[index].id.toString()}$index',
                          child: Image.network(
                            pokemons[index].thumbnailImage,
                          ),
                        ),
                        title: Text(pokemons[index].name),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

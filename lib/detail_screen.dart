import 'package:flutter/material.dart';
import 'package:flutter_app/Pokemon.dart';

class DetailScreen extends StatelessWidget {
  final Pokemon pokemon;
  final int index;

  const DetailScreen({Key key, this.pokemon, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: Center(
        child: Hero(
          tag: '${pokemon.id.toString()}$index',
          child: Image.network(pokemon.thumbnailImage),
        ),
      ),
    );
  }
}

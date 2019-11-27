
import 'dart:convert';

import 'package:flutter_app/Pokemon.dart';
import 'package:flutter_app/TypePokemon.dart';
import 'package:http/http.dart' as http;

class Service{

  Future<List<Pokemon>> loadPokemons() async{
    http.Response response = await http.get("http://rafaelbarbosatec.github.io/api/pokemon/pokemons.json");
    List json = jsonDecode(response.body);
    return json.map<Pokemon>((i){
      return Pokemon.fromJson(i);
    }).toList();
  }

  Future<List<TypePokemon>> loadTypes() async{
    http.Response response = await http.get("http://rafaelbarbosatec.github.io/api/pokemon/types.json");
    Map json = jsonDecode(response.body);
    List types = json["results"];
    return types.map<TypePokemon>((i){
      return TypePokemon.fromJson(i);
    }).toList();
  }


}
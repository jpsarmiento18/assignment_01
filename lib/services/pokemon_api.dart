import 'dart:convert';

import 'package:http/http.dart' as http;

/// The PokeAPI endpoint 
const String pokemonEndpoint = 'https://pokeapi.co/api/v2/pokemon';

/// Returns JSON data for the pokemon [pokemonName]
Future<dynamic> getPokemonByName({required String pokemonName}) async {
  final url = Uri.parse('$pokemonEndpoint/$pokemonName');
  final response = await http.get(url);
  return jsonDecode(response.body);
}
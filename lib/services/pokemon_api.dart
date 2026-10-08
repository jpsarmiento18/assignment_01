import 'dart:convert';

import 'package:http/http.dart' as http;

/// The PokeAPI endpoint 
const String pokemonEndpoint = 'https://pokeapi.co/api/v2/pokemon';

/// Returns JSON data for the pokemon [pokemonName]
/// Throws an [Exception] if the request fails or status code isn't 200
Future<dynamic> getPokemonByName({required String pokemonName}) async {
  final url = Uri.parse('$pokemonEndpoint/$pokemonName'); //sticks the name on the end of the endpoint
  http.Response response;
  try{
    response = await http.get(url);
  }
  catch (e) {
    throw Exception('There was a problem with the request: $e');
  }
  
  // kept outside the try so the catch doesn't wrap this error a second time
  if (response.statusCode != 200) {
    throw Exception(
      'There was a problem with the request: status ${response.statusCode} received');
  }
  //json string to dart map
  return jsonDecode(response.body);
}
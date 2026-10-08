import 'package:assignment_01/models/pokemon.dart';
import 'package:assignment_01/services/pokemon_api.dart' as pokemon_api;

void main(List<String> arguments) async {
  // Example Pokemon name
  final data = await pokemon_api.getPokemonByName(pokemonName: 'pikachu');

  // Create Pokemon object from API data
  // Use current date/time for capture date since API doesn't provide this
  final pokemon = Pokemon.fromPokeApiData(data);

  print(pokemon);
}

import 'package:test/test.dart';
import 'package:assignment_01/services/pokemon_api.dart' as pokemon_api;

// Generate mock for http.Client

void main() {
  group('Pokemon API Tests', () {
    // This test makes real HTTP requests, so it should be run in an environment where network access is available.
    // This is unideal
    test('getPokemonByName returns Pokemon data for valid name', () async {
      // Act
      final result = await pokemon_api.getPokemonByName(pokemonName: 'pikachu');

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['name'], equals('pikachu'));
      expect(result['id'], equals(25));
    });

    test(
      'getPokemonByName throws an exception when request fails or not status 200',
      () async {
        expect(
          () async =>
              await pokemon_api.getPokemonByName(pokemonName: 'doesnotexist'),
          throwsA(
            isA<Exception>().having(
              (exception) => exception.toString(),
              'message',
              contains(
                'There was a problem with the request: ',
              ), // The error message.
            ),
          ),
        );
      },
    );
  });
}

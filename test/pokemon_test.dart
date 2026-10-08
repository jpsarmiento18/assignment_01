import 'package:test/test.dart';
import 'package:assignment_01/models/pokemon.dart';

void main() {
  group('Pokemon Class', () {
    test('Constructor creates a valid Pokemon', () {
      // Arrange & Act
      final pokemon = Pokemon(
        name: 'Pikachu',
        id: 25,
        height: 0.4, // 4 decimeters = 0.4 meters
        weight: 6.0, // 60 hectograms = 6.0 kg
        baseExperience: 112,
        types: ['electric'],
        captureDate: DateTime.now(),
      );

      // Assert
      expect(pokemon.name, equals('Pikachu'));
      expect(pokemon.id, equals(25));
      expect(pokemon.height, equals(0.4));
      expect(pokemon.weight, equals(6.0));
      expect(pokemon.baseExperience, equals(112));
      expect(pokemon.types, equals(['electric']));
      expect(
        pokemon.captureDate.isBefore(DateTime.now().add(Duration(seconds: 1))),
        isTrue,
      );
    });

    test('fromPokeApiData creates a valid Pokemon', () {
      // Arrange
      final now = DateTime.now();
      final data = {
        'name': 'charizard',
        'id': 6,
        'height': 17, // 17 decimeters
        'weight': 905, // 905 hectograms
        'base_experience': 267,
        'types': [
          {
            'slot': 1,
            'type': {
              'name': 'fire',
              'url': 'https://pokeapi.co/api/v2/type/10/',
            },
          },
          {
            'slot': 2,
            'type': {
              'name': 'flying',
              'url': 'https://pokeapi.co/api/v2/type/3/',
            },
          },
        ],
      };

      // Act
      final pokemon = Pokemon.fromPokeApiData(data);

      // Assert
      expect(pokemon.name, equals('charizard'));
      expect(pokemon.id, equals(6));
      expect(pokemon.height, equals(1.7)); // Converted to meters
      expect(pokemon.weight, equals(90.5)); // Converted to kg
      expect(pokemon.baseExperience, equals(267));
      expect(pokemon.types, containsAll(['fire', 'flying']));
      expect(pokemon.types.length, equals(2));
      expect(pokemon.captureDate, equals(now));
    });

    group('Validation Tests', () {
      test('Name validation throws exception for empty name', () {
        // Arrange, Act & Assert
        expect(
          () => Pokemon(
            name: '',
            id: 25,
            height: 0.4,
            weight: 6.0,
            baseExperience: 112,
            types: ['electric'],
            captureDate: DateTime.now(),
          ),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains('Pokemon name cannot be empty'),
            ),
          ),
        );
      });

      test('ID validation throws exception for non-positive ID', () {
        // Arrange, Act & Assert
        expect(
          () => Pokemon(
            name: 'Pikachu',
            id: 0, // Zero is not positive
            height: 0.4,
            weight: 6.0,
            baseExperience: 112,
            types: ['electric'],
            captureDate: DateTime.now(),
          ),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains('Pokemon ID must be positive'),
            ),
          ),
        );

        expect(
          () => Pokemon(
            name: 'Pikachu',
            id: -1, // Negative is not positive
            height: 0.4,
            weight: 6.0,
            baseExperience: 112,
            types: ['electric'],
            captureDate: DateTime.now(),
          ),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains('Pokemon ID must be positive'),
            ),
          ),
        );
      });

      test('Height validation throws exception for out-of-range height', () {
        // Arrange, Act & Assert - Too small
        expect(
          () => Pokemon(
            name: 'Pikachu',
            id: 25,
            height: 0.05, // Too small
            weight: 6.0,
            baseExperience: 112,
            types: ['electric'],
            captureDate: DateTime.now(),
          ),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains(
                    'Pokemon height must be between 0.1 and 20.0 meters',
                  ),
            ),
          ),
        );

        // Too large
        expect(
          () => Pokemon(
            name: 'Pikachu',
            id: 25,
            height: 25.0, // Too large
            weight: 6.0,
            baseExperience: 112,
            types: ['electric'],
            captureDate: DateTime.now(),
          ),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains(
                    'Pokemon height must be between 0.1 and 20.0 meters',
                  ),
            ),
          ),
        );
      });

      test('Weight validation throws exception for out-of-range weight', () {
        // Arrange, Act & Assert - Too small
        expect(
          () => Pokemon(
            name: 'Pikachu',
            id: 25,
            height: 0.4,
            weight: 0.05, // Too small
            baseExperience: 112,
            types: ['electric'],
            captureDate: DateTime.now(),
          ),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains(
                    'Pokemon weight must be between 0.1 and 1000.0 kilograms',
                  ),
            ),
          ),
        );

        // Too large
        expect(
          () => Pokemon(
            name: 'Pikachu',
            id: 25,
            height: 0.4,
            weight: 1500.0, // Too large
            baseExperience: 112,
            types: ['electric'],
            captureDate: DateTime.now(),
          ),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains(
                    'Pokemon weight must be between 0.1 and 1000.0 kilograms',
                  ),
            ),
          ),
        );
      });

      test(
        'Base experience validation throws exception for out-of-range value',
        () {
          // Arrange, Act & Assert - Too small
          expect(
            () => Pokemon(
              name: 'Pikachu',
              id: 25,
              height: 0.4,
              weight: 6.0,
              baseExperience: 0, // Too small
              types: ['electric'],
              captureDate: DateTime.now(),
            ),
            throwsA(
              predicate(
                (e) =>
                    e is Exception &&
                    e.toString().contains(
                      'Base experience must be between 1 and 1000',
                    ),
              ),
            ),
          );

          // Too large
          expect(
            () => Pokemon(
              name: 'Pikachu',
              id: 25,
              height: 0.4,
              weight: 6.0,
              baseExperience: 1200, // Too large
              types: ['electric'],
              captureDate: DateTime.now(),
            ),
            throwsA(
              predicate(
                (e) =>
                    e is Exception &&
                    e.toString().contains(
                      'Base experience must be between 1 and 1000',
                    ),
              ),
            ),
          );
        },
      );

      test('Types validation throws exception for empty types list', () {
        // Arrange, Act & Assert
        expect(
          () => Pokemon(
            name: 'Pikachu',
            id: 25,
            height: 0.4,
            weight: 6.0,
            baseExperience: 112,
            types: [], // Empty list
            captureDate: DateTime.now(),
          ),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains(
                    'Pokemon must have between 1 and 2 types',
                  ),
            ),
          ),
        );
      });

      test('Types validation throws exception for too many types', () {
        // Arrange, Act & Assert
        expect(
          () => Pokemon(
            name: 'Pikachu',
            id: 25,
            height: 0.4,
            weight: 6.0,
            baseExperience: 112,
            types: ['electric', 'fire', 'water'], // Too many types
            captureDate: DateTime.now(),
          ),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains(
                    'Pokemon must have between 1 and 2 types',
                  ),
            ),
          ),
        );
      });

      test('Types validation throws exception for invalid type', () {
        // Arrange, Act & Assert
        expect(
          () => Pokemon(
            name: 'Pikachu',
            id: 25,
            height: 0.4,
            weight: 6.0,
            baseExperience: 112,
            types: ['invalid-type'], // Invalid type
            captureDate: DateTime.now(),
          ),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains('Invalid Pokemon type: invalid-type'),
            ),
          ),
        );
      });

      test('Capture date validation throws exception for future date', () {
        // Arrange, Act & Assert
        expect(
          () => Pokemon(
            name: 'Pikachu',
            id: 25,
            height: 0.4,
            weight: 6.0,
            baseExperience: 112,
            types: ['electric'],
            captureDate: DateTime.now().add(Duration(days: 1)), // Future date
          ),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains('Capture date cannot be in the future'),
            ),
          ),
        );
      });
    });

    test('toString returns formatted string', () {
      // Arrange
      final captureDate = DateTime(2025, 5, 10);
      final pokemon = Pokemon(
        name: 'Pikachu',
        id: 25,
        height: 0.4,
        weight: 6.0,
        baseExperience: 112,
        types: ['electric'],
        captureDate: captureDate,
      );

      // Act
      final result = pokemon.toString();

      // Assert
      expect(
        result,
        equals(
          'Pokemon: Pikachu (#25), Type(s): [electric], Height: 0.4m, Weight: 6.0kg, Base Experience: 112, Captured: $captureDate',
        ),
      );
    });

    test('Type validation accepts all valid Pokemon types', () {
      // This test ensures all valid types from the specification work
      final validTypes = [
        "normal",
        "fire",
        "water",
        "electric",
        "grass",
        "ice",
        "fighting",
        "poison",
        "ground",
        "flying",
        "psychic",
        "bug",
        "rock",
        "ghost",
        "dragon",
        "dark",
        "steel",
        "fairy",
      ];

      // Test each type individually
      for (final type in validTypes) {
        final pokemon = Pokemon(
          name: 'Test Pokemon',
          id: 1,
          height: 1.0,
          weight: 10.0,
          baseExperience: 100,
          types: [type],
          captureDate: DateTime.now(),
        );

        expect(pokemon.types.contains(type), isTrue);
      }
    });
  });
}

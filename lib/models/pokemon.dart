class Pokemon {
  // all the official types, used to check the types setter
  static const List<String> _validPokemonTypes = [
    'normal',
    'fire',
    'water',
    'electric',
    'grass',
    'ice',
    'fighting',
    'poison',
    'ground',
    'flying',
    'psychic',
    'bug',
    'rock',
    'ghost',
    'dragon',
    'dark',
    'steel',
    'fairy',
  ];

  // late since the setters fill these in from the constructor
  late String _name;
  late int _id;
  late double _height;
  late double _weight;
  late int _baseExperience;
  late List<String> _types;
  late DateTime _captureDate;

  // goes through the setters so everything gets validated
  Pokemon({
    required String name,
    required int id,
    required double height,
    required double weight,
    required int baseExperience,
    required List<String> types,
    required DateTime captureDate,
  }) {
    this.name = name;
    this.id = id;
    this.height = height;
    this.weight = weight;
    this.baseExperience = baseExperience;
    this.types = types;
    this.captureDate = captureDate;
  }

  /// Makes a Pokemon from the api data
  factory Pokemon.fromPokeApiData(dynamic data) {
    // get the type names
    List<String> types = [];

    for (var type in data['types']) {
      types.add(type['type']['name']);
    }

    return Pokemon(
      name: data['name'],
      id: data['id'],
      height: data['height'] / 10, // to meters
      weight: data['weight'] / 10, // to kg
      baseExperience: data['base_experience'],
      types: types,
      captureDate: DateTime.now(), // api doesn't have this
    );
  }

  /// The name of the pokemon
  String get name {
    return _name;
  }

  set name(String value) {
    // trim so "   " counts as empty too
    if (value.trim().isEmpty) {
      throw Exception('Pokemon name cannot be empty');
    }

    _name = value;
  }

  /// The id of the pokemon
  int get id {
    return _id;
  }

  set id(int value) {
    if (value <= 0) {
      throw Exception('Pokemon ID must be positive');
    }

    _id = value;
  }

  /// The height of the pokemon in meters
  double get height {
    return _height;
  }

  set height(double value) {
    if (value < 0.1 || value > 20.0) {
      throw Exception('Pokemon height must be between 0.1 and 20.0 meters');
    }

    _height = value;
  }

  /// The weight of the pokemon in kilograms
  double get weight {
    return _weight;
  }

  set weight(double value) {
    if (value < 0.1 || value > 1000.0) {
      throw Exception(
        'Pokemon weight must be between 0.1 and 1000.0 kilograms',
      );
    }

    _weight = value;
  }

  /// The base experience of the pokemon
  int get baseExperience {
    return _baseExperience;
  }

  set baseExperience(int value) {
    if (value < 1 || value > 1000) {
      throw Exception('Base experience must be between 1 and 1000');
    }

    _baseExperience = value;
  }

  /// The types of the pokemon
  List<String> get types {
    return _types;
  }

  set types(List<String> value) {
    // every pokemon has 1 or 2 types
    if (value.isEmpty || value.length > 2) {
      throw Exception('Pokemon must have between 1 and 2 types');
    }

    // make sure each type is actually a real one
    for (var type in value) {
      if (!_validatePokemonType(type)) {
        throw Exception('Invalid Pokemon type: $type');
      }
    }

    _types = value;
  }

  /// The date the pokemon was captured
  DateTime get captureDate {
    return _captureDate;
  }

  set captureDate(DateTime value) {
    if (value.isAfter(DateTime.now())) {
      throw Exception('Capture date cannot be in the future');
    }

    _captureDate = value;
  }

  // true if the type is in the valid list
  bool _validatePokemonType(String type) {
    return _validPokemonTypes.contains(type);
  }

  @override
  String toString() {
    return 'Pokemon: $_name (#$_id), Type(s): $_types, Height: ${_height}m, Weight: ${_weight}kg, Base Experience: $_baseExperience, Captured: $_captureDate';
  }
}

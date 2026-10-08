A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.
2026-sep-assignment-1-dart-pokemon-api-a01
Assignment 1 for dart, class A01

DMIT2504 Assignment 01 - Dart Language Primer (2025)
Weight: 10% of final mark

Overview
For this assignment, you will create a Dart application that interacts with the PokeAPI to retrieve and model Pokemon data. You'll practice API interaction, data modeling, validation, and error handling.

Pokemon API and Data Model
This assignment uses the public PokeAPI (https://pokeapi.co/), which doesn't require authentication. You'll use their Pokemon endpoints to retrieve information about different Pokemon species.

Requirements
Create a Pokemon Service API
Create a services/ directory in the lib/ directory
Create a pokemon_api.dart file in the services/ directory
The following requirements must be met:
Export a constant named pokemonEndpoint with the value https://pokeapi.co/api/v2/pokemon
Export a function getPokemonByName that accepts a Pokemon name as a named parameter (pokemonName) and returns the Future<dynamic> JSON data object from the PokeAPI endpoint
If the response status code is anything other than 200, throw an Exception with message: There was a problem with the request: status <status code> received
If an exception occurs when accessing the endpoint, throw an Exception with message: There was a problem with the request: <original exception message>
Create a Pokemon class
Create a models/ directory in the lib/ directory

Create a pokemon.dart file in the models/ directory

Create a private static const list of valid Pokemon types named _validPokemonTypes with all officially recognized types: "normal", "fire", "water", "electric", "grass", "ice", "fighting", "poison", "ground", "flying", "psychic", "bug", "rock", "ghost", "dragon", "dark", "steel", "fairy"

The Pokemon class requires the following:

Private members for:

name (string)
id (integer)
height (double) - converted from decimeters to meters
weight (double) - converted from hectograms to kilograms
baseExperience (integer)
types (List<String>) - list of Pokemon types (e.g., "fire", "water")
captureDate (datetime)
Getters and setters for all private members with the following validations:

name: must not be empty (Exception: 'Pokemon name cannot be empty')
id: must be positive (Exception: 'Pokemon ID must be positive')
height: must be between 0.1 and 20.0 meters (Exception: 'Pokemon height must be between 0.1 and 20.0 meters')
weight: must be between 0.1 and 1000.0 kilograms (Exception: 'Pokemon weight must be between 0.1 and 1000.0 kilograms')
baseExperience: must be between 1 and 1000 (Exception: 'Base experience must be between 1 and 1000')
types: must contain at least one and at most two types (Exception: 'Pokemon must have between 1 and 2 types') each type must be one of the valid Pokemon types (Exception: 'Invalid Pokemon type: <type>')
captureDate: must not be in the future (Exception: 'Capture date cannot be in the future')
A generative constructor with required named parameters for each member

A factory constructor fromPokeApiData that accepts a single dynamic data parameter

The method must parse required fields and use the generative constructor
NOTE: The PokeAPI provides height in decimeters and weight in hectograms, which need to be converted to meters and kilograms
NOTE: captureDate is not a field returned from the API. This factory constructor should use current time as the captureDate.
Create a private helper method _validatePokemonType that checks if a given type string is in the list of valid types. Use this to validate types in your setter.

Override the toString() method to return a string in the following format:

Pokemon: <name> (#<id>), Type(s): <types>, Height: <height>m, Weight: <weight>kg, Base Experience: <baseExperience>, Captured: <captureDate>
NOTE: You can use the default .toString() for the date and types should be represented as a comma separated list in square brackets. i.e. [fire, steel]
Use the automated tests as a guide ($ flutter test -r expanded test).

Submission Requirements
Follow Dart programming conventions (Effective Dart). Your code must compile and not throw unexpected runtime exceptions. Code that does not compile will not be graded. Code must be committed and pushed to the GitHub classroom assignment repository before the deadline.

NOTE: You must demonstrate incremental development of your solution. This means that you must begin work on your solution as soon as possible and commit often to the assignment repository. Each commit must demonstrate functional improvements to the solution. Failure to show incremental work during the assignment period will result in loss of marks of up to 20%.

Additionally, you are encouraged to use external resources to help you learn what is needed for the assignment. However, if you submit code that differs greatly from what was demonstrated in class it must be documented (e.g. comments, citations, etc.) and you may be asked to provide a verbal explanation of how the code works to your instructor. Failure to explain any code you submitted will be considered as potential evidence of academic misconduct and may trigger an investigation, potentially resulting in further consequences.

Marking Rubrics [Assignment total 10]
Pokemon API Implementation [4%]
Mark	Description
4	Excellent – API implementation correctly handles all requirements: exports required constants, implements getPokemonByName function with proper parameter handling, performs error handling with appropriate exception messages, and follows Dart best practices (proper async/await usage, error propagation, etc.)
3	Good – API implementation satisfies core requirements but has minor issues: may have inconsistent error handling, lacks some code documentation, or doesn't follow Dart best practices in some areas (e.g., unnecessary async operations, inefficient HTTP request handling)
2	Satisfactory – API implementation works for basic cases but has noticeable gaps: may be missing proper exception messages, lacks robust error handling for edge cases, or uses unconventional approaches that differ from class examples without proper documentation
1	Needs Improvement – API implementation has significant issues: doesn't handle errors properly, crashes on invalid input, missing required functionality, or poorly structured code that doesn't follow Dart conventions
0	Unsatisfactory – API implementation doesn't compile, is missing entirely, or fails to perform basic API calls
Pokemon Class Implementation [6%]
Mark	Description
6	Outstanding – Class implementation is exemplary: all required properties with proper getters/setters, complete validation logic including type validation against the predefined list, correct unit conversions, proper factory constructor implementation, thorough error handling with specific exception messages, and follows all Dart best practices
5	Excellent – Class implementation is very strong: includes all required functionality with only minor issues in code organization, validation implementation, or best practices
4	Good – Class implementation satisfies requirements but has room for improvement: may have inconsistent validation logic, minor issues with unit conversion, less elegant implementation of the factory constructor, or some deviation from best practices
3	Satisfactory – Class implementation works for basic usage but has gaps: may be missing some validation checks, has inconsistent error messages, or uses approaches that differ significantly from class examples without justification
2	Basic – Class implementation has significant shortcomings: missing multiple validation requirements, incorrect unit conversions, incomplete factory constructor implementation, or major structural issues
1	Needs Improvement – Class implementation is incomplete: contains only minimal functionality, crashes on basic inputs, or fails to implement core requirements
0	Unsatisfactory – Class implementation doesn't compile, is missing entirely, or fails fundamental requirements
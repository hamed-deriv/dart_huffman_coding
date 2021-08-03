void main(List<String> arguments) {
  final Map<String, int> result =
      sortCharacters(getCharacterCount('Some Text To test'));

  print(result);
}

Map<String, int> getCharacterCount(String input) {
  final Map<String, int> result = <String, int>{};

  for (int i = 0; i < input.length; i++) {
    result.containsKey(input[i])
        ? result[input[i]] = result[input[i]]! + 1
        : result[input[i]] = 1;
  }

  return result;
}

Map<String, int> sortCharacters(Map<String, int> characters) {
  final List<MapEntry<String, int>> mapEntries = characters.entries.toList()
    ..sort(
      (MapEntry<String, int> first, MapEntry<String, int> second) =>
          first.value.compareTo(second.value),
    );

  characters
    ..clear()
    ..addEntries(mapEntries);

  return characters;
}

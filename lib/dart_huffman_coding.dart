void main(List<String> arguments) {
  final Map<String, int> result = sortCharacters(
    getCharacterCount(
      'In computer science and information theory, a Huffman code is a particular type of optimal prefix code that is commonly used for lossless data compression.',
    ),
  );

  printTree(generateTree(result));
}

void printTree(NodeTree? node) {
  print('${node!.char} ${node.value}');

  if (node.left != null) {
    printTree(node.left);
  }

  if (node.right != null) {
    printTree(node.right);
  }
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

NodeTree? generateTree(Map<String, int> characters) {
  final List<NodeTree> queue = <NodeTree>[];

  for (final MapEntry<String, int> item in characters.entries) {
    queue.add(NodeTree(value: item.value, char: item.key));
  }

  while (queue.length > 1) {
    final NodeTree left = queue.removeAt(getLowestFrequency(queue));
    final NodeTree right = queue.removeAt(getLowestFrequency(queue));

    final NodeTree newNode = NodeTree(
      value: left.value + right.value,
      char: '${left.char}${right.char}',
      left: left,
      right: right,
    );

    queue.add(newNode);
  }

  return queue.first;
}

int getLowestFrequency(List<NodeTree> queue) {
  int index = 0;

  for (int i = 0; i < queue.length; i++) {
    if (queue[i].value < queue[index].value) {
      index = i;
    }
  }

  return index;
}

class NodeTree {
  NodeTree({required this.value, this.char, this.left, this.right});

  final int value;
  final String? char;
  final NodeTree? left;
  final NodeTree? right;
}

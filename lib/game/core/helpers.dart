import 'package:flutter/services.dart';

final up = {LogicalKeyboardKey.arrowUp, LogicalKeyboardKey.keyZ};
final left = {LogicalKeyboardKey.arrowLeft, LogicalKeyboardKey.keyQ};
final right = {LogicalKeyboardKey.arrowRight, LogicalKeyboardKey.keyD};
final down = {LogicalKeyboardKey.arrowDown, LogicalKeyboardKey.keyS};
final space = {LogicalKeyboardKey.space};

bool containsKeys(Set input1, Set input2) {
  for (var element in input1) {
    if (input2.contains(element)) {
      return true;
    }
  }
  return false;
}

final keysWatched = <LogicalKeyboardKey>{
  ...up,
  ...left,
  ...right,
  ...down,
  ...space
};

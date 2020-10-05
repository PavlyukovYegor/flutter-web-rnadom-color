import 'dart:math';
import 'dart:ui';

import 'package:colorGenerator/services/random_color_generator.dart';

class BackgroundColorService implements RandomColorGenerator {

  Random random = Random();
  int _getRandomShape() => random.nextInt(255);

  @override
  Color generateRandomColor() {
    final int redShape = _getRandomShape();
    final int greenShape = _getRandomShape();
    final int blueShape = _getRandomShape();
    return Color.fromRGBO(redShape, greenShape, blueShape, 1);
  }


}
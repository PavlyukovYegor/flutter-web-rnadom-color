import 'package:flutter/material.dart';

class TextColorService {

  int _getInverseShape(int shape) {
    int inverseShape = 255 - shape;
    return inverseShape;
  }

  Color getTextColor(Color backgroundColor) {
    final int redShape = _getInverseShape(backgroundColor.red);
    final int greenShape = _getInverseShape(backgroundColor.green);
    final int blueShape = _getInverseShape(backgroundColor.blue);
    return Color.fromRGBO(redShape, greenShape, blueShape, 1);
  }

}
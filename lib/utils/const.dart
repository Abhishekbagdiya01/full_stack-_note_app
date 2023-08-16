import 'package:flutter/material.dart';

const blackColor = Colors.black;
const whiteColor = Colors.white;
const goldColor = Color.fromARGB(255, 246, 237, 200);
const greenColor = Color.fromARGB(255, 167, 214, 114);
const blueColor = Color.fromARGB(255, 152, 183, 219);

Color getColorByIndex(int index) {
  List<Color> colors = [goldColor, greenColor, blueColor];
  return colors[index % colors.length];
}

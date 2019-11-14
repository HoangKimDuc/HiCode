import 'package:flutter/material.dart';

class InvertedRectClipper extends CustomClipper<Path> {
  InvertedRectClipper({this.size});
  final double size;
  @override
  Path getClip(Size csize) {
    return new Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(csize.width / 2, csize.height / 2),
            width: size,
            height: size,
          ),
          Radius.circular(6.0)))
      ..addRect(new Rect.fromLTWH(0.0, 0.0, csize.width, csize.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gamify_app/utils/constans.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double height;
  final Function onTap;
  final Widget child;
  final Color? color;
  const CustomButton({
    this.width,
    required this.height,
    required this.onTap,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: ClipPath(
        child: Container(
          width: width,
          height: height,
          color: color ?? kButtonColor,
          child: Center(
            child: child,
          ),
        ),
        clipper: HexagonalClipper(),
      ),
    );
  }
}

class HexagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path
      ..lineTo(size.width * 0.10, 0)
      ..lineTo(size.width * 0.90, 0)
      ..lineTo(size.width, size.height * sqrt(4) / 4)
      ..lineTo(size.width * 0.90, size.height * sqrt(4) / 2)
      ..lineTo(size.width * 0.10, size.height * sqrt(4) / 2)
      ..lineTo(0, size.height * sqrt(4) / 4)
      ..lineTo(size.width * 0.10, 0)
      ..close();
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

import 'package:flutter/material.dart';
import 'package:gamify_app/utils/constans.dart';

class MenuOption extends StatelessWidget {
  final String image;
  final bool active;
  const MenuOption({
    required this.image,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        color: active ? Color(0xFF6F6F6F).withOpacity(0.5) : kBackgroundColor,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset(
            image,
            height: 40,
          ),
        ),
      ),
    );
  }
}

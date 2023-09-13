import 'package:flutter/material.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';

class Points extends StatelessWidget {
  final int points;
  const Points({
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
            border: Border.all(
              color: kActiveColor,
              width: 3,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 40,
              ),
              Text(
                '$points',
                style: const TextStyle(
                  color: kActiveColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: kPressStart2PFont,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        Image.asset(
          kMoneyImagePath,
          width: 30,
        ),
      ],
    );
  }
}

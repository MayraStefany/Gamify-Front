import 'package:flutter/material.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';

class Gamify extends StatefulWidget {
  const Gamify({super.key});

  @override
  State<Gamify> createState() => _GamifyState();
}

class _GamifyState extends State<Gamify> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          kLogoImagePath,
          height: 80,
        ),
        const SizedBox(
          height: 5,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 60,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: kAtomicAgeFont,
            ),
            children: [
              TextSpan(
                text: 'Gam',
              ),
              TextSpan(
                text: 'i',
                style: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
              TextSpan(
                text: 'fy',
              ),
            ],
          ),
        )
      ],
    );
  }
}

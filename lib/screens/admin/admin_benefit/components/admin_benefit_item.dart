import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gamify_app/components/points.dart';
import 'package:gamify_app/models/benefit.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/utils.dart';

class AdminBenefitItem extends StatelessWidget {
  final Benefit benefit;
  const AdminBenefitItem({
    required this.benefit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border.all(color: kGrayColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Points(
                  points: benefit.points!,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Uint8List bytes = Base64Codec().decode(benefit.file!);
                Utils.downloadFile(
                  bytes: bytes,
                  fileName: benefit.name!,
                  mimeType: benefit.type!,
                  context: context,
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    kBenefitImagePath,
                    width: 90,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    benefit.name!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: kRulukoFont,
                      color: kGrayColor,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

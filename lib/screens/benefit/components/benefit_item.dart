import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gamify_app/components/points.dart';
import 'package:gamify_app/models/benefit.dart';
import 'package:gamify_app/screens/benefit/components/buy_benefit_dialog.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/utils.dart';

class BenefitItem extends StatelessWidget {
  final Benefit benefit;
  final bool myBenefit;
  final Function onRefresh;
  const BenefitItem({
    required this.benefit,
    this.myBenefit = false,
    required this.onRefresh,
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
            if (!myBenefit) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showCustomDialog(
                        context: context,
                        benefit: benefit,
                      );
                    },
                    child: Points(
                      points: benefit.points!,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
            GestureDetector(
              onTap: myBenefit
                  ? () {
                      Uint8List bytes = Base64Codec().decode(benefit.file!);
                      Utils.downloadFile(
                        bytes: bytes,
                        fileName: benefit.name!,
                        mimeType: benefit.type!,
                        context: context,
                      );
                    }
                  : null,
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

  Future<void> showCustomDialog({
    required BuildContext context,
    required Benefit benefit,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(color: Color(0xFFE3DDDD)),
          ),
          backgroundColor: Colors.black,
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          content: BuyBenefitDialog(
            dialogContext: dialogContext,
            benefit: benefit,
            onRefresh: onRefresh,
          ),
        ),
      ),
    );
  }
}

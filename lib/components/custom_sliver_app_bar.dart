import 'package:flutter/material.dart';
import 'package:gamify_app/screens/event_summary/event_summary_screen.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';

class CustomSliverAppBar extends StatelessWidget {
  final bool graphicDisabled;
  const CustomSliverAppBar({this.graphicDisabled = false});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kBackgroundColor,
      title: Row(
        children: [
          Image.asset(
            kLogoImagePath,
            height: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 20,
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
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 12,
            top: 5,
            bottom: 5,
          ),
          child: graphicDisabled
              ? GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: kGrayColor,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventSummaryScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      kBarChartImagePath,
                      width: 30,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

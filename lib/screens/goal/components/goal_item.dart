import 'package:flutter/material.dart';
import 'package:gamify_app/models/goal.dart';
import 'package:gamify_app/screens/goal/components/goal_dialog.dart';
import 'package:gamify_app/utils/constans.dart';

class GoalItem extends StatelessWidget {
  final Goal goal;
  final Function onRefresh;
  const GoalItem({
    required this.goal,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: kBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${goal.title}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontFamily: kRulukoFont,
                  color: kGrayColor,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showCustomDialog(
                  context: context,
                  goal: goal,
                  onRefresh: onRefresh,
                );
              },
              child: const Icon(
                Icons.remove_red_eye_outlined,
                color: kGrayColor,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showCustomDialog({
    required BuildContext context,
    required Goal goal,
    required Function onRefresh,
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
          content: GoalDialog(
            dialogContext: dialogContext,
            goalId: goal.id!,
            onRefresh: onRefresh,
          ),
        ),
      ),
    );
  }
}

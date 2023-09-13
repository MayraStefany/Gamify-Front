import 'package:flutter/material.dart';
import 'package:gamify_app/models/goal.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:intl/intl.dart';

class GoalInfo extends StatelessWidget {
  final Goal goal;
  const GoalInfo({
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = Color(0xFF878383);
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: defaultColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 160,
            width: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              color: Color(0xFFA9DF9C),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${goal.title}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFA9DF9C),
                        fontFamily: kRulukoFont,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '.  ${goal.description ?? '-'}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: kRulukoFont,
                        color: kGrayColor,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '.  ${DateFormat('dd/MM/yyyy').format(DateTime.parse(goal.date!))}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: kRulukoFont,
                        color: kGrayColor,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '.  ${goal.course!.name ?? '-'}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: kRulukoFont,
                        color: kGrayColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

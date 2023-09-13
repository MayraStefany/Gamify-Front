import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/screens/goal/components/goal_page.dart';
import 'package:gamify_app/screens/goal/new_goal_screen.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen();

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  GlobalKey<GoalPageState> goalPage = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Añadir objetivo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: kRulukoFont,
              color: kGrayColor,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CustomButton(
            height: 35,
            width: 50,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewGoalScreen(
                    onRefresh: () {
                      goalPage.currentState!.setData();
                    },
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.add,
              size: 35,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: kGrayColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              kGoalImagePath,
                              width: 50,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Objetivo',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w400,
                                fontFamily: kBungeeFont,
                                color: kGrayColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: GoalPage(
                  key: goalPage,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

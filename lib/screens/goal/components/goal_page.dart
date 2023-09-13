import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamify_app/models/goal.dart';
import 'package:gamify_app/screens/goal/components/goal_item.dart';
import 'package:gamify_app/services/goal_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:provider/provider.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => GoalPageState();
}

class GoalPageState extends State<GoalPage> {
  final goalService = GoalService.instance;
  List<Goal>? goals = [];
  bool isShowSpinner = false;

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    setState(() => isShowSpinner = true);
    final user = Provider.of<AppState>(context, listen: false).user;
    goals = await goalService.getGoalsByUser(userId: user!.userId);
    setState(() => isShowSpinner = false);
  }

  @override
  Widget build(BuildContext context) {
    return isShowSpinner
        ? SpinKitCircle(
            size: kSizeLoading,
            itemBuilder: (BuildContext context, int index) {
              return const DecoratedBox(
                decoration: BoxDecoration(
                  color: kGrayColor,
                ),
              );
            },
          )
        : Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: goals!
                    .map((goal) => GoalItem(
                          goal: goal,
                          onRefresh: () => setData(),
                        ))
                    .toList(),
              ),
            ),
          );
  }
}

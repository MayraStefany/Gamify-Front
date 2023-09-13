import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_sliver_app_bar.dart';
import 'package:gamify_app/components/loading_page.dart';
import 'package:gamify_app/models/goal.dart';
import 'package:gamify_app/screens/goal/components/goal_form.dart';
import 'package:gamify_app/services/goal_service.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'package:gamify_app/utils/utils.dart';

class NewGoalScreen extends StatefulWidget {
  final Function onRefresh;
  const NewGoalScreen({
    required this.onRefresh,
  });

  @override
  State<NewGoalScreen> createState() => _NewGoalScreenState();
}

class _NewGoalScreenState extends State<NewGoalScreen> {
  final goalService = GoalService.instance;
  bool isShowSpinner = false;

  @override
  Widget build(BuildContext context) {
    return LoadingPage(
      isShowSpinner: isShowSpinner,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              CustomSliverAppBar(),
              SliverFillRemaining(
                child: GoalForm(
                  onGetGoal: (Goal goal) {
                    registerGoal(goal);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerGoal(Goal goal) async {
    try {
      FocusScope.of(context).unfocus();
      setState(() => isShowSpinner = true);
      await goalService.registerGoal(
        goal: goal,
      );
      Navigator.pop(context);
      widget.onRefresh();
      Utils.showCustomDialog(
        context: context,
        text: 'Objetivo registrado con éxito',
      );
    } catch (e) {
      Utils.showCustomDialog(
        context: context,
        text: (e is ServiceException) ? e.message : kMensajeErrorGenerico,
        isError: true,
      );
    } finally {
      setState(() => isShowSpinner = false);
    }
  }
}

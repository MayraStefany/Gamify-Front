import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/models/goal.dart';
import 'package:gamify_app/screens/goal/components/goal_info.dart';
import 'package:gamify_app/services/goal_service.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'package:gamify_app/utils/utils.dart';

class GoalDialog extends StatefulWidget {
  final String goalId;
  final Function onRefresh;
  final BuildContext dialogContext;
  const GoalDialog({
    required this.goalId,
    required this.onRefresh,
    required this.dialogContext,
  });

  @override
  State<GoalDialog> createState() => _GoalDialogState();
}

class _GoalDialogState extends State<GoalDialog> {
  final goalService = GoalService.instance;
  bool isShowSpinner = false;
  Goal? goal;

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() async {
    setState(() => isShowSpinner = true);
    goal = await goalService.getGoal(
      goalId: widget.goalId,
    );
    setState(() => isShowSpinner = false);
  }

  Future<void> completeGoal() async {
    try {
      setState(() => isShowSpinner = true);
      await goalService.completeGoal(
        goalId: goal!.id!,
      );
      goal = await goalService.getGoal(
        goalId: widget.goalId,
      );
      widget.onRefresh();
      Utils.showCustomDialog(
        context: context,
        text: 'Objetivo completado con éxito',
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        goal != null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (goal!.complete!)
                          ? const Text(
                              '¡Eres un ejemplo a seguir!',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w400,
                                fontFamily: kRulukoFont,
                                color: Color(0xFFA9DF9C),
                              ),
                            )
                          : const Text(
                              'Detalle',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w400,
                                fontFamily: kRulukoFont,
                                color: kGrayColor,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: GoalInfo(
                          goal: goal!,
                        ),
                      ),
                      if (goal!.complete! == false) ...[
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: CustomButton(
                            height: 45,
                            color: Color(0xFF495F75),
                            onTap: () {
                              completeGoal();
                            },
                            child: const Text(
                              'Completar Objetivo',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: kRulukoFont,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              )
            : const SizedBox(
                width: 100,
                height: 200,
              ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(widget.dialogContext);
            },
            child: const Icon(
              Icons.close,
              color: kGrayColor,
            ),
          ),
        ),
        if (isShowSpinner)
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.black.withOpacity(0.6),
              child: const Center(
                child: CircularProgressIndicator(
                  color: kGrayColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

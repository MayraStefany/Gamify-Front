import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/components/points.dart';
import 'package:gamify_app/models/benefit.dart';
import 'package:gamify_app/models/user.dart';
import 'package:gamify_app/services/benefit_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'package:gamify_app/utils/utils.dart';
import 'package:provider/provider.dart';

class BuyBenefitDialog extends StatefulWidget {
  final BuildContext dialogContext;
  final Benefit benefit;
  final Function onRefresh;

  const BuyBenefitDialog({
    required this.dialogContext,
    required this.benefit,
    required this.onRefresh,
  });

  @override
  State<BuyBenefitDialog> createState() => _BuyBenefitDialogState();
}

class _BuyBenefitDialogState extends State<BuyBenefitDialog> {
  final benefitService = BenefitService.instance;
  bool isShowSpinner = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> buyBenefit() async {
    try {
      setState(() => isShowSpinner = true);
      final user = Provider.of<AppState>(context, listen: false).user;
      final points = await benefitService.buyBenefit(
        userId: user!.userId,
        benefitId: widget.benefit.id!,
      );
      await Provider.of<AppState>(context, listen: false).setUser(
        user: User(
          userId: user.userId,
          email: user.email,
          password: user.password,
          points: points,
          isAdmin: user.isAdmin,
          isGlobalSurveyDone: user.isGlobalSurveyDone,
          token: user.token,
        ),
      );
      Navigator.pop(context);
      widget.onRefresh();
      Utils.showCustomDialog(
        context: context,
        text: 'Beneficio comprado con éxito',
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
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.benefit.name!,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    fontFamily: kRulukoFont,
                    color: kGrayColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Points(
                        points: widget.benefit.points!,
                      ),
                    ],
                  ),
                ),
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
                      buyBenefit();
                    },
                    child: const Text(
                      'Comprar',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: kGugiFont,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
              color: Colors.black.withOpacity(0.6),
              width: double.infinity,
              height: double.infinity,
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

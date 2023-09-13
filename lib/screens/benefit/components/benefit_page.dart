import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamify_app/models/benefit.dart';
import 'package:gamify_app/screens/benefit/components/benefit_item.dart';
import 'package:gamify_app/services/benefit_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:provider/provider.dart';

class BenefitPage extends StatefulWidget {
  final bool myBenefit;
  const BenefitPage({
    this.myBenefit = false,
  });

  @override
  State<BenefitPage> createState() => _BenefitPageState();
}

class _BenefitPageState extends State<BenefitPage> {
  final benefitService = BenefitService.instance;
  List<Benefit>? benefits = [];
  bool isShowSpinner = false;

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    setState(() => isShowSpinner = true);
    final user = Provider.of<AppState>(context, listen: false).user;
    benefits = widget.myBenefit
        ? await benefitService.getMyBenefits(userId: user!.userId)
        : await benefitService.getBenefits();
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
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 25,
                children: benefits!
                    .map(
                      (benefit) => BenefitItem(
                        benefit: benefit,
                        myBenefit: widget.myBenefit,
                        onRefresh: () => setData(),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
  }
}

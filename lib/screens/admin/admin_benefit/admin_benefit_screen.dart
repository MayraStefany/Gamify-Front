import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/models/benefit.dart';
import 'package:gamify_app/screens/admin/admin_benefit/components/admin_benefit_item.dart';
import 'package:gamify_app/screens/admin/admin_benefit/new_admin_benefit_screen.dart';
import 'package:gamify_app/services/benefit_service.dart';
import 'package:gamify_app/utils/constans.dart';

class AdminBenefitScreen extends StatefulWidget {
  const AdminBenefitScreen();

  @override
  State<AdminBenefitScreen> createState() => _AdminBenefitScreenState();
}

class _AdminBenefitScreenState extends State<AdminBenefitScreen> {
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
    benefits = await benefitService.getBenefits();
    setState(() => isShowSpinner = false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Beneficios registrados:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: kRulukoFont,
                    color: kGrayColor,
                  ),
                ),
                CustomButton(
                  height: 35,
                  width: 50,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewAdminBenefitScreen(
                          onRefresh: () => setData(),
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
          ),
          isShowSpinner
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
                  padding: const EdgeInsets.all(20),
                  child: benefits!.isNotEmpty
                      ? Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          runSpacing: 25,
                          children: benefits!
                              .map(
                                (benefit) => AdminBenefitItem(
                                  benefit: benefit,
                                ),
                              )
                              .toList(),
                        )
                      : Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              color: Color(0xFF878383),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Ninguno',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF878383),
                                fontFamily: kRulukoFont,
                              ),
                            ),
                          ),
                        ),
                ),
        ],
      ),
    );
  }
}

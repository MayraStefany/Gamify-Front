import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_sliver_app_bar.dart';
import 'package:gamify_app/components/loading_page.dart';
import 'package:gamify_app/models/benefit.dart';
import 'package:gamify_app/screens/admin/admin_benefit/components/admin_benefit_form.dart';
import 'package:gamify_app/services/benefit_service.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'package:gamify_app/utils/utils.dart';

class NewAdminBenefitScreen extends StatefulWidget {
  final Function onRefresh;
  const NewAdminBenefitScreen({
    required this.onRefresh,
  });

  @override
  State<NewAdminBenefitScreen> createState() => _NewAdminBenefitScreenState();
}

class _NewAdminBenefitScreenState extends State<NewAdminBenefitScreen> {
  final benefitService = BenefitService.instance;
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
                child: AdminBenefitForm(
                  onGetBenefit: (Benefit benefit, File file) {
                    registerBenefit(benefit, file);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerBenefit(Benefit benefit, File file) async {
    try {
      FocusScope.of(context).unfocus();
      setState(() => isShowSpinner = true);
      await benefitService.registerBenefit(
        benefit: benefit,
        file: file,
      );
      Navigator.pop(context);
      widget.onRefresh();
      Utils.showCustomDialog(
        context: context,
        text: 'Beneficio registrado con éxito',
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

import 'package:flutter/material.dart';
import 'package:gamify_app/screens/admin/admin_screen.dart';
import 'package:gamify_app/screens/login/login_screen.dart';
import 'package:gamify_app/screens/menu/menu_screen.dart';
import 'package:gamify_app/screens/survey/global_survey_screen.dart';
import 'package:gamify_app/services/global_config_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class InitScreen extends StatefulWidget {
  static const String id = 'init_screen';
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  final globalConfigService = GlobalConfigService.instance;
  late String imagen;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        final userExists =
            await Provider.of<AppState>(context, listen: false).userExists();
        if (userExists) {
          final user = Provider.of<AppState>(context, listen: false).user;
          await Provider.of<AppState>(context, listen: false).deleteRefresh();
          final weekId = await globalConfigService.getWeekId();
          await Provider.of<AppState>(context, listen: false).setWeekId(
            weekId: weekId,
          );
          Navigator.pushReplacementNamed(
            context,
            user!.isAdmin!
                ? AdminScreen.id
                : user.isGlobalSurveyDone!
                    ? MenuScreen.id
                    : GlobalSurveyScreen.id,
          );
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: GlowingProgressIndicator(
          child: Image.asset(
            kLogoImagePath,
            width: 144,
          ),
        ),
      ),
    );
  }
}

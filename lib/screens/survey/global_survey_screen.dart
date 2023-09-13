import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/components/loading_page.dart';
import 'package:gamify_app/components/survey_item.dart';
import 'package:gamify_app/models/global_survey.dart';
import 'package:gamify_app/models/user.dart';
import 'package:gamify_app/screens/register/general_screen.dart';
import 'package:gamify_app/services/global_survey_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'package:gamify_app/utils/utils.dart';
import 'package:provider/provider.dart';

class GlobalSurveyScreen extends StatefulWidget {
  static const String id = 'global_survey_screen';
  const GlobalSurveyScreen({super.key});

  @override
  State<GlobalSurveyScreen> createState() => _GlobalSurveyScreenState();
}

class _GlobalSurveyScreenState extends State<GlobalSurveyScreen> {
  final globalSurveyService = GlobalSurveyService.instance;
  GlobalSurvey? globalSurvey;
  bool isShowSpinner = false;

  @override
  void initState() {
    super.initState();
    globalSurvey = GlobalSurvey();
  }

  Future<void> saveGlobalSurvey() async {
    try {
      setState(() => isShowSpinner = true);
      User? user = Provider.of<AppState>(context, listen: false).user;
      globalSurvey?.userId = user?.userId;
      await globalSurveyService.createGlobalSurvey(
        globalSurvey: globalSurvey!,
      );
      user?.isGlobalSurveyDone = true;
      await Provider.of<AppState>(context, listen: false).setUser(
        user: user!,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => GeneralScreen(),
        ),
        (route) => false,
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
    return LoadingPage(
      isShowSpinner: isShowSpinner,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            kMyTimeAndTasksHeaderImagePath,
                            width: 50,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Column(
                            children: [
                              Text(
                                'MI TIEMPO Y',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: kBungeeFont,
                                  color: kGrayColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'TAREAS',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          SurveyItem(
                            text: '1. Nivel de participación en clases:',
                            onTap: (int value) {
                              globalSurvey?.participation = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SurveyItem(
                            text: '2. Nivel de cumplimiento de tareas:',
                            onTap: (int value) {
                              globalSurvey?.taskCompletion = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SurveyItem(
                            text:
                                '3. ¿Cómo evaluarías tus habilidades para gestionar tu tiempo?',
                            onTap: (int value) {
                              globalSurvey?.timeManagement = value;
                            },
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          CustomButton(
                            height: 45,
                            onTap: () {
                              if (globalSurvey?.participation != null &&
                                  globalSurvey?.taskCompletion != null &&
                                  globalSurvey?.timeManagement != null) {
                                saveGlobalSurvey();
                              } else {
                                Utils.showMessage(
                                    context, 'Debe completar la encuesta');
                              }
                            },
                            child: const Text(
                              'Siguiente',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: kGugiFont,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

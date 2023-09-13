import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/components/custom_text_field.dart';
import 'package:gamify_app/components/gamify.dart';
import 'package:gamify_app/components/loading_page.dart';
import 'package:gamify_app/models/user.dart';
import 'package:gamify_app/screens/admin/admin_screen.dart';
import 'package:gamify_app/screens/menu/menu_screen.dart';
import 'package:gamify_app/screens/recover_password/verification_code_screen.dart';
import 'package:gamify_app/screens/survey/global_survey_screen.dart';
import 'package:gamify_app/screens/register/register_screen.dart';
import 'package:gamify_app/services/firebase_messaging_service.dart';
import 'package:gamify_app/services/global_config_service.dart';
import 'package:gamify_app/services/user_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'package:gamify_app/utils/utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userService = UserService.instance;
  final globalConfigService = GlobalConfigService.instance;
  final firebaseMessagingService = FirebaseMessagingService.instance;
  final form = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController(text: '');
  TextEditingController controllerPassword = TextEditingController(text: '');
  late AutovalidateMode autovalidateMode;
  bool isShowSpinner = false;

  @override
  void initState() {
    super.initState();
    autovalidateMode = AutovalidateMode.disabled;
    setState(() {});
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
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Form(
                    key: form,
                    child: Column(
                      children: [
                        const Gamify(),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 50,
                              ),
                              child: Column(
                                children: [
                                  CustomTextField(
                                    autovalidateMode: autovalidateMode,
                                    hintText: 'Correo',
                                    onChange: (value) => setState(
                                      () => controllerEmail.value =
                                          TextEditingValue(
                                        text: value,
                                        selection: controllerEmail.selection,
                                      ),
                                    ),
                                    validator: (value) {
                                      String? mensaje;
                                      if (value.isEmpty) {
                                        mensaje =
                                            'Por favor ingrese su correo gmail';
                                      } else {
                                        if (!Utils.isValidEmail(value)) {
                                          mensaje =
                                              'El correo gmail no es válido';
                                        }
                                      }
                                      return mensaje;
                                    },
                                    inputType: TextInputType.emailAddress,
                                    controller: controllerEmail,
                                    prefixImage: kPersonImagePath,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                    autovalidateMode: autovalidateMode,
                                    hintText: 'Contraseña',
                                    onChange: (value) => setState(
                                      () => controllerPassword.value =
                                          TextEditingValue(
                                        text: value,
                                        selection: controllerPassword.selection,
                                      ),
                                    ),
                                    validator: (value) {
                                      String? mensaje;
                                      if (value.isEmpty) {
                                        mensaje =
                                            'Por favor ingrese contraseña correcta';
                                      }
                                      return mensaje;
                                    },
                                    obscureText: true,
                                    inputType: TextInputType.text,
                                    controller: controllerPassword,
                                    prefixImage: kPasswordImagePath,
                                  ),
                                ],
                              ),
                            ),
                            CustomButton(
                              height: 45,
                              onTap: () {
                                if (form.currentState!.validate()) {
                                  signIn();
                                } else {
                                  setState(
                                    () => autovalidateMode =
                                        AutovalidateMode.always,
                                  );
                                  Utils.showMessage(
                                    context,
                                    'Por favor complete todo los campos',
                                  );
                                }
                              },
                              child: const Text(
                                'Iniciar Sesión',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontFamily: kGugiFont,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VerificationCodeScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kGrayColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 1,
                                    width: 100,
                                    color: kGrayColor,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text(
                                    'O',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: kGrayColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 1,
                                    width: 100,
                                    color: kGrayColor,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Crear una cuenta',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kGrayColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    try {
      FocusScope.of(context).unfocus();
      setState(() => isShowSpinner = true);
      User user = await userService.signIn(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );
      user.token = await firebaseMessagingService.getTokenDispositivo();
      await userService.addToken(
        token: user.token!,
        userId: user.userId,
      );
      await Provider.of<AppState>(context, listen: false).deleteRefresh();
      final weekId = await globalConfigService.getWeekId();
      await Provider.of<AppState>(context, listen: false).setUser(
        user: user,
      );
      await Provider.of<AppState>(context, listen: false).setWeekId(
        weekId: weekId,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => user.isAdmin!
              ? AdminScreen()
              : (user.isGlobalSurveyDone!)
                  ? MenuScreen()
                  : GlobalSurveyScreen(),
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
}

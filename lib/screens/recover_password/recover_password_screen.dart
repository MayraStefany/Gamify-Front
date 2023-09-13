import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/components/custom_text_field.dart';
import 'package:gamify_app/components/gamify.dart';
import 'package:gamify_app/components/loading_page.dart';
import 'package:gamify_app/models/user.dart';
import 'package:gamify_app/screens/admin/admin_screen.dart';
import 'package:gamify_app/screens/menu/menu_screen.dart';
import 'package:gamify_app/screens/survey/global_survey_screen.dart';
import 'package:gamify_app/services/firebase_messaging_service.dart';
import 'package:gamify_app/services/global_config_service.dart';
import 'package:gamify_app/services/user_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'package:gamify_app/utils/utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class RecoverPasswordScreen extends StatefulWidget {
  static const String id = 'recover_password_screen';
  final String? email;
  const RecoverPasswordScreen({
    this.email,
  });

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final userService = UserService.instance;
  final globalConfigService = GlobalConfigService.instance;
  final firebaseMessagingService = FirebaseMessagingService.instance;
  final form = GlobalKey<FormState>();
  TextEditingController controllerVerificationCode = TextEditingController();
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
                    vertical: 20,
                  ),
                  child: Form(
                    key: form,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                                color: kGrayColor,
                              ),
                            ),
                          ],
                        ),
                        const Gamify(),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 50,
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Ingrese el código\nde verificación',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontFamily: kBungeeFont,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: PinCodeTextField(
                                      errorTextSpace: 0,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      appContext: context,
                                      cursorHeight: 16,
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      length: 6,
                                      animationType: AnimationType.scale,
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        fieldHeight: 45,
                                        fieldWidth: 45,
                                        activeFillColor: Color(0xFF495F75),
                                        activeColor: Color(0xFF676565),
                                        inactiveFillColor: Color(0xFF495F75),
                                        inactiveColor: Color(0xFF676565),
                                        selectedFillColor: Color(0xFF495F75),
                                        selectedColor: Color(0xFF676565),
                                      ),
                                      cursorColor: kGrayColor,
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      enableActiveFill: true,
                                      controller: controllerVerificationCode,
                                      keyboardType: TextInputType.number,
                                      onCompleted: (_) {},
                                      onChanged: (_) => setState(() {}),
                                      beforeTextPaste: (_) => false,
                                    ),
                                  ),
                                  CustomTextField(
                                    autovalidateMode: autovalidateMode,
                                    hintText: 'Nueva Contraseña',
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
                                            'Por favor ingrese la nueva contraseña correcta';
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
                                if (form.currentState!.validate() &&
                                    controllerVerificationCode.text.length ==
                                        6) {
                                  verification();
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
                                'Verificar',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontFamily: kGugiFont,
                                ),
                              ),
                            ),
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

  Future<void> verification() async {
    try {
      FocusScope.of(context).unfocus();
      setState(() => isShowSpinner = true);
      await userService.recoverPassword(
        email: widget.email!,
        password: controllerPassword.text,
        recoverCode: controllerVerificationCode.text,
      );
      User user = await userService.signIn(
        email: widget.email!,
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

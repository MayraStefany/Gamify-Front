import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/components/custom_text_field.dart';
import 'package:gamify_app/components/gamify.dart';
import 'package:gamify_app/components/loading_page.dart';
import 'package:gamify_app/screens/recover_password/recover_password_screen.dart';
import 'package:gamify_app/services/user_service.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'package:gamify_app/utils/utils.dart';

class VerificationCodeScreen extends StatefulWidget {
  static const String id = 'verification_code_screen';
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final userService = UserService.instance;
  final form = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController(text: '');
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
                                    'ENTER YOUR EMAIL ADDRESS:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontFamily: kBungeeFont,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                    autovalidateMode: autovalidateMode,
                                    hintText: 'email@xxx.com',
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
                                ],
                              ),
                            ),
                            CustomButton(
                              height: 45,
                              onTap: () {
                                if (form.currentState!.validate()) {
                                  recoverPassword();
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
                                'Enviar',
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

  Future<void> recoverPassword() async {
    try {
      FocusScope.of(context).unfocus();
      setState(() => isShowSpinner = true);
      bool sent = await userService.recoverCodeToEmail(
        email: controllerEmail.text,
      );
      if (sent) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecoverPasswordScreen(
              email: controllerEmail.text,
            ),
          ),
        );
      } else {
        Utils.showCustomDialog(
          context: context,
          text: 'No se pudo enviar el código de verificación',
          isError: true,
        );
      }
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

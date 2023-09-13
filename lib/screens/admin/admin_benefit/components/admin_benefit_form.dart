import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/components/custom_text_field.dart';
import 'package:gamify_app/models/benefit.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/utils.dart';

class AdminBenefitForm extends StatefulWidget {
  final Function onGetBenefit;
  const AdminBenefitForm({
    required this.onGetBenefit,
  });

  @override
  State<AdminBenefitForm> createState() => _AdminBenefitFormState();
}

class _AdminBenefitFormState extends State<AdminBenefitForm> {
  final form = GlobalKey<FormState>();
  TextEditingController controllerTitle = TextEditingController(text: '');
  TextEditingController controllerPoints = TextEditingController(text: '');
  late AutovalidateMode autovalidateMode;
  bool isShowSpinner = false;
  Benefit? benefit;
  File? file;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    autovalidateMode = AutovalidateMode.disabled;
    benefit = Benefit();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
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
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              'NUEVO BENEFICIO',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                fontFamily: kBungeeFont,
                color: kGrayColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Form(
              key: form,
              child: Column(
                children: [
                  CustomTextField(
                    autovalidateMode: autovalidateMode,
                    hintText: 'Título',
                    onChange: (value) => setState(
                      () => controllerTitle.value = TextEditingValue(
                        text: value,
                        selection: controllerTitle.selection,
                      ),
                    ),
                    validator: (value) {
                      String? mensaje;
                      if (value.isEmpty) {
                        mensaje = 'Por favor ingrese el título';
                      }
                      return mensaje;
                    },
                    inputType: TextInputType.text,
                    controller: controllerTitle,
                    color: kGrayColor,
                    borderColor: kGrayColor,
                  ),
                  CustomTextField(
                    autovalidateMode: autovalidateMode,
                    hintText: 'Puntos',
                    onChange: (value) => setState(
                      () => controllerPoints.value = TextEditingValue(
                        text: value,
                        selection: controllerPoints.selection,
                      ),
                    ),
                    validator: (value) {
                      String? mensaje;
                      if (value.isEmpty) {
                        mensaje = 'Por favor ingrese los puntos';
                      }
                      return mensaje;
                    },
                    inputType: TextInputType.number,
                    controller: controllerPoints,
                    color: kGrayColor,
                    borderColor: kGrayColor,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: kGrayColor,
                      ),
                    ),
                    child: file != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                kBenefitImagePath,
                                width: 90,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                child: const Text(
                                  'Eliminar',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red,
                                    fontFamily: kRulukoFont,
                                  ),
                                ),
                                onTap: () {
                                  setState(() => file = null);
                                },
                              )
                            ],
                          )
                        : GestureDetector(
                            onTap: () async {
                              final newfile = await Utils.selectFile();
                              if (newfile != null) {
                                file = newfile;
                                setState(() {});
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  kPdfImagePath,
                                  height: 50,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Cargar archivo (Solo pdf)',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: kGrayColor,
                                    fontFamily: kRulukoFont,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    height: 45,
                    onTap: () {
                      if (form.currentState!.validate() && file != null) {
                        widget.onGetBenefit(getBenefit(), file);
                      } else {
                        setState(
                          () => autovalidateMode = AutovalidateMode.always,
                        );
                        Utils.showMessage(
                          context,
                          'Por favor complete todo los campos',
                        );
                      }
                    },
                    child: const Text(
                      'Guardar',
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
          ),
        ],
      ),
    );
  }

  Benefit getBenefit() {
    benefit?.name = controllerTitle.text;
    benefit?.points = int.parse(controllerPoints.text);
    return benefit!;
  }
}

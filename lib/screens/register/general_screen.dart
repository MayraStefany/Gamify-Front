import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/screens/menu/menu_screen.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';

class GeneralScreen extends StatelessWidget {
  final bool showButton;
  const GeneralScreen({
    this.showButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Column(
                      children: [
                        if (!showButton)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              kGeneralHeaderImagePath,
                              width: 50,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Column(
                              children: [
                                Text(
                                  'GENERAL',
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              width: 2,
                              color: Color(0xFF676565),
                            ),
                            color: Colors.black,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 40,
                              horizontal: 20,
                            ),
                            child: Column(
                              children: [
                                Description(
                                  text:
                                      'Por cada actividad completada, el usuario recibirá puntos (PONFUS).',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Description(
                                  text:
                                      'Los puntos podrán canjearse por diferentes beneficios.',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Description(
                                  text:
                                      'Se recomienda registrar al menos 3 actividades académicas por semana (horario de clases, estudio y reuniones de equipo)',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Description(
                                  text:
                                      'Al finalizar cada semana, se deberá completar una encuesta, que también otorgará puntos.',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Description(
                                  text:
                                      'La aplicación toma en cuenta la duración de un ciclo académico (16 semanas).',
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (showButton) ...[
                          const SizedBox(
                            height: 60,
                          ),
                          CustomButton(
                            height: 45,
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuScreen(),
                                ),
                                (route) => false,
                              );
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
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  final String text;
  const Description({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: kRulukoFont,
            color: kGrayColor,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: kRulukoFont,
              color: kGrayColor,
            ),
          ),
        ),
      ],
    );
  }
}

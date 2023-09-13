import 'package:flutter/material.dart';
import 'package:gamify_app/utils/constans_assets.dart';

class DetailedActivityItem extends StatelessWidget {
  const DetailedActivityItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color titleColor = Color(0xFFDFE1DE);
    Color descriptionColor = Color(0xFF647461);

    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mega Importante:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: titleColor,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 110,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: Color(0xFFA9DF9C).withOpacity(0.7),
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                            color: Colors.red,
                            image: DecorationImage(
                              image: AssetImage(kBackgroundImagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const SizedBox(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            child: Center(
                              child: Text(
                                'Examen Parcial de Estadistica',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            color: Color(0xFFA9DF9C),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 13,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '- Histograma',
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400,
                                            color: descriptionColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          '- Media y Mediana',
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400,
                                            color: descriptionColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'Fecha: 16/05/2023',
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400,
                                            color: descriptionColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gamify_app/screens/login/login_screen.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/utils.dart';
import 'package:provider/provider.dart';

class MainSliverAppBar extends StatelessWidget {
  const MainSliverAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kBackgroundColor,
      title: Row(
        children: [
          Image.asset(
            kLogoImagePath,
            height: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: kAtomicAgeFont,
              ),
              children: [
                TextSpan(
                  text: 'Gam',
                ),
                TextSpan(
                  text: 'i',
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
                TextSpan(
                  text: 'fy',
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 12,
          ),
          child: GestureDetector(
            onTap: () async {
              try {
                Provider.of<AppState>(context, listen: false).resetAppState();
                Navigator.of(context, rootNavigator: true)
                  ..pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
              } catch (e) {
                Utils.showCustomDialog(
                  context: context,
                  text: 'Ocurrio un error al cerrar sesión',
                  isError: true,
                );
              }
            },
            child: Container(
              width: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: kPrimaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      kExitImagePath,
                      width: 20,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Salir',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        fontFamily: kAtomicAgeFont,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

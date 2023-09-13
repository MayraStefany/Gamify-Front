import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamify_app/firebase_options.dart';
import 'package:gamify_app/screens/admin/admin_screen.dart';
import 'package:gamify_app/screens/init_screen.dart';
import 'package:gamify_app/screens/login/login_screen.dart';
import 'package:gamify_app/screens/menu/menu_screen.dart';
import 'package:gamify_app/screens/recover_password/recover_password_screen.dart';
import 'package:gamify_app/screens/survey/global_survey_screen.dart';
import 'package:gamify_app/screens/register/register_screen.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterSecureStorage().write(
    key: kStorageRefresh,
    value: jsonEncode({
      'actualizar': true,
    }),
  );
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Gamify',
        debugShowCheckedModeBanner: false,
        initialRoute: InitScreen.id,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          SfGlobalLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', 'US'),
          Locale('es'),
          Locale('en'),
        ],
        routes: {
          InitScreen.id: (context) => InitScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          GlobalSurveyScreen.id: (context) => GlobalSurveyScreen(),
          RecoverPasswordScreen.id: (context) => RecoverPasswordScreen(),
          MenuScreen.id: (context) => MenuScreen(),
          AdminScreen.id: (context) => AdminScreen(),
        },
      ),
    );
  }
}

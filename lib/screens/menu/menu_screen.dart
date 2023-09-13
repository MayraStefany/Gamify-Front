import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gamify_app/screens/activity/activity_screen.dart';
import 'package:gamify_app/screens/benefit/benefit_screen.dart';
import 'package:gamify_app/screens/home/home_screen.dart';
import 'package:gamify_app/screens/menu/components/menu_option.dart';
import 'package:gamify_app/screens/notification/notification_screen.dart';
import 'package:gamify_app/screens/survey/survey_screen.dart';
import 'package:gamify_app/services/firebase_messaging_service.dart';
import 'package:gamify_app/services/global_config_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  static const String id = 'menu_screen';
  const MenuScreen({
    super.key,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with WidgetsBindingObserver {
  late PersistentTabController _controller;
  final firebaseMessagingService = FirebaseMessagingService.instance;
  final globalConfigService = GlobalConfigService.instance;
  Stream stream =
      Stream.periodic(const Duration(seconds: 5)).asBroadcastStream();
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initData();
  }

  Future<void> initData() async {
    _controller = PersistentTabController(initialIndex: 0);
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    firebaseMessagingService.initMessaging(context);
    streamSubscription = stream.listen((_) async {
      final refresh =
          await Provider.of<AppState>(context, listen: false).refresh();
      if (refresh) {
        await Provider.of<AppState>(context, listen: false).deleteRefresh();
        final weekId = await globalConfigService.getWeekId();
        await Provider.of<AppState>(context, listen: false).setWeekId(
          weekId: weekId,
        );
        await Provider.of<AppState>(context, listen: false)
            .setUpdateNotifications(
          updateNotifications: true,
        );
      }
    });
    setState(() {});
  }

  void _handleMessage(RemoteMessage message) {
    print('message: $message');
  }

  List<Widget> _buildScreens(BuildContext context) {
    return [
      HomeScreen(),
      SurveyScreen(),
      ActivityScreen(),
      BenefitScreen(),
      NotificationScreen(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    streamSubscription?.cancel();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        title: 'Menú',
        activeColorPrimary: kMenuColor,
        inactiveColorPrimary: kMenuColor.withOpacity(0.5),
        textStyle: const TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.w400,
          fontFamily: kAtomicAgeFont,
        ),
        icon: const MenuOption(
          image: kHomeMenuImagePath,
          active: true,
        ),
        inactiveIcon: const MenuOption(
          image: kHomeMenuInactivatedImagePath,
        ),
      ),
      PersistentBottomNavBarItem(
        title: 'Encuesta',
        activeColorPrimary: kMenuColor,
        inactiveColorPrimary: kMenuColor.withOpacity(0.5),
        textStyle: const TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.w400,
          fontFamily: kAtomicAgeFont,
        ),
        icon: const MenuOption(
          image: kSurveyMenuImagePath,
          active: true,
        ),
        inactiveIcon: const MenuOption(
          image: kSurveyMenuInactivatedImagePath,
        ),
      ),
      PersistentBottomNavBarItem(
        title: 'Calendario',
        activeColorPrimary: kMenuColor,
        inactiveColorPrimary: kMenuColor.withOpacity(0.5),
        textStyle: const TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.w400,
          fontFamily: kAtomicAgeFont,
        ),
        icon: const MenuOption(
          image: kCalendarMenuImagePath,
          active: true,
        ),
        inactiveIcon: const MenuOption(
          image: kCalendarMenuInactivatedImagePath,
        ),
      ),
      PersistentBottomNavBarItem(
        title: 'Beneficio',
        activeColorPrimary: kMenuColor,
        inactiveColorPrimary: kMenuColor.withOpacity(0.5),
        textStyle: const TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.w400,
          fontFamily: kAtomicAgeFont,
        ),
        icon: const MenuOption(
          image: kBenefitMenuImagePath,
          active: true,
        ),
        inactiveIcon: const MenuOption(
          image: kBenefitMenuInactivatedImagePath,
        ),
      ),
      PersistentBottomNavBarItem(
        title: 'Notificación',
        activeColorPrimary: kMenuColor,
        inactiveColorPrimary: kMenuColor.withOpacity(0.5),
        textStyle: const TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.w400,
          fontFamily: kAtomicAgeFont,
        ),
        icon: const MenuOption(
          image: kNotificationMenuImagePath,
          active: true,
        ),
        inactiveIcon: const MenuOption(
          image: kNotificationMenuInactivatedImagePath,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      navBarHeight: 70,
      controller: _controller,
      screens: _buildScreens(context),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: kBackgroundColor,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}

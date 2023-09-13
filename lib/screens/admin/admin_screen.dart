import 'package:flutter/material.dart';
import 'package:gamify_app/components/main_sliver_app_bar.dart';
import 'package:gamify_app/screens/admin/admin_benefit/admin_benefit_screen.dart';
import 'package:gamify_app/screens/admin/admin_course/admin_course_screen.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';

class AdminScreen extends StatefulWidget {
  static const String id = 'admin_screen';
  const AdminScreen();

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late int _indexTab;

  @override
  void initState() {
    super.initState();
    _indexTab = 0;
    _controller = TabController(
      vsync: this,
      length: 2,
      initialIndex: _indexTab,
    );
    _controller.addListener(() {
      setState(() => _indexTab = _controller.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            MainSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Text(
                      '¡BIENVENIDO ADMIN!',
                      style: TextStyle(
                        fontSize: 26,
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
                    child: Column(
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(kAvatarImagePath),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(60),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: const EdgeInsets.symmetric(vertical: 15),
                    labelColor: kGrayColor,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: kBungeeFont,
                      color: kGrayColor,
                    ),
                    controller: _controller,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: kActiveColor,
                        width: 3,
                      ),
                    ),
                    tabs: const [
                      Text(
                        'CURSOS',
                      ),
                      Text(
                        'BENEFICIOS',
                      ),
                    ],
                    onTap: (index) => setState(
                      () => _indexTab = index,
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _controller,
                children: [
                  AdminCourseScreen(),
                  AdminBenefitScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

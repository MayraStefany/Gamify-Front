import 'package:flutter/material.dart';
import 'package:gamify_app/components/main_sliver_app_bar.dart';
import 'package:gamify_app/components/user_points.dart';
import 'package:gamify_app/screens/home/components/course_page.dart';
import 'package:gamify_app/utils/constans.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<CoursePageState> coursePage = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: kBackgroundColor,
          backgroundColor: kGrayColor,
          displacement: 30,
          strokeWidth: 2,
          onRefresh: () async {
            await coursePage.currentState!.setData();
          },
          child: CustomScrollView(
            slivers: [
              MainSliverAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    UserPoints(),
                    CoursePage(
                      key: coursePage,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

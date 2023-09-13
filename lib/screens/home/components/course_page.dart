import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamify_app/models/course.dart';
import 'package:gamify_app/screens/home/components/course_record_item.dart';
import 'package:gamify_app/services/course_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => CoursePageState();
}

class CoursePageState extends State<CoursePage> {
  final courseService = CourseService.instance;
  List<Course>? courses = [];
  Course? selectedCourse;
  bool isShowSpinner = false;
  bool showCourses = false;
  AppState? appState;

  @override
  void initState() {
    super.initState();
    setData();
    appState = Provider.of<AppState>(context, listen: false);
    appState!.addListener(setData);
  }

  Future<void> setData() async {
    setState(() => isShowSpinner = true);
    courses!.clear();
    final weekId = Provider.of<AppState>(context, listen: false).weekId;
    courses = await courseService.getCourses();
    courses!.forEach((course) {
      final index = course.records?.indexWhere((week) => week.weekId == weekId);
      for (int i = 0; i <= index!; i++) {
        course.records?[i].painted = true;
      }
    });
    selectedCourse = courses?.first;
    setState(() => isShowSpinner = false);
  }

  @override
  void dispose() {
    super.dispose();
    appState!.removeListener(setData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: isShowSpinner
          ? SpinKitCircle(
              size: kSizeLoading,
              itemBuilder: (BuildContext context, int index) {
                return const DecoratedBox(
                  decoration: BoxDecoration(
                    color: kGrayColor,
                  ),
                );
              },
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() => showCourses = !showCourses);
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [
                            CourseItem(
                              text: selectedCourse!.name!,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: showCourses
                                  ? Transform.rotate(
                                      angle: 90 * math.pi / 180,
                                      child: const Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      if (showCourses)
                        Column(
                          children: courses!
                              .where((course) =>
                                  course.courseId != selectedCourse!.courseId)
                              .map(
                                (course) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedCourse = course;
                                        showCourses = !showCourses;
                                      });
                                    },
                                    child: CourseItem(
                                      text: course.name!,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: selectedCourse!.records!
                      .map((courseRecord) => CourseRecordItem(
                            courseRecord: courseRecord,
                          ))
                      .toList(),
                )
              ],
            ),
    );
  }
}

class CourseItem extends StatelessWidget {
  final String text;
  const CourseItem({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 46,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: const Color(0xFF863F48),
          width: 1.5,
        ),
        color: kButtonColor,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            right: 45,
            left: 10,
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: kGrayColor,
              fontSize: 22,
              fontWeight: FontWeight.w400,
              fontFamily: kGugiFont,
            ),
          ),
        ),
      ),
    );
  }
}

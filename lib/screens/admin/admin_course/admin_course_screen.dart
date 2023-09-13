import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/models/course.dart';
import 'package:gamify_app/screens/admin/admin_course/components/admin_course_item.dart';
import 'package:gamify_app/screens/admin/admin_course/new_admin_course_screen.dart';
import 'package:gamify_app/services/course_service.dart';
import 'package:gamify_app/utils/constans.dart';

class AdminCourseScreen extends StatefulWidget {
  const AdminCourseScreen();

  @override
  State<AdminCourseScreen> createState() => _AdminCourseScreenState();
}

class _AdminCourseScreenState extends State<AdminCourseScreen> {
  final courseService = CourseService.instance;
  List<Course>? courses = [];
  bool isShowSpinner = false;

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    setState(() => isShowSpinner = true);
    courses = await courseService.getCourses();
    setState(() => isShowSpinner = false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cursos registrados:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: kRulukoFont,
                    color: kGrayColor,
                  ),
                ),
                CustomButton(
                  height: 35,
                  width: 50,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewAdminCourseScreen(
                          onRefresh: () => setData(),
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          isShowSpinner
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
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: courses!.isNotEmpty
                      ? Column(
                          children: courses!
                              .map(
                                (course) => AdminCourseItem(
                                  course: course,
                                ),
                              )
                              .toList(),
                        )
                      : Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              color: Color(0xFF878383),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 160,
                                width: 40,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                  color: Color(0xFF878383),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Ninguno',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF878383),
                                        fontFamily: kRulukoFont,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                ),
        ],
      ),
    );
  }
}

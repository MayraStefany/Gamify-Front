import 'package:flutter/material.dart';
import 'package:gamify_app/models/course.dart';
import 'package:gamify_app/screens/admin/admin_course/detail_admin_course_screen.dart';
import 'package:gamify_app/utils/constans.dart';

class AdminCourseItem extends StatelessWidget {
  final Course course;
  const AdminCourseItem({
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = Color(0xFF878383);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailAdminCourseScreen(
                course: course,
              ),
            ),
          );
        },
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(
              color: defaultColor,
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
                  color: kGreenColor,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.name!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFA9DF9C),
                          fontFamily: kRulukoFont,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

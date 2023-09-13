import 'package:flutter/material.dart';
import 'package:gamify_app/models/course.dart';
import 'package:gamify_app/screens/home/components/course_page.dart';
import 'package:gamify_app/screens/home/components/course_record_item.dart';
import 'package:gamify_app/utils/constans.dart';

class DetailAdminCourseScreen extends StatefulWidget {
  final Course course;
  const DetailAdminCourseScreen({
    required this.course,
  });

  @override
  State<DetailAdminCourseScreen> createState() =>
      _DetailAdminCourseScreenState();
}

class _DetailAdminCourseScreenState extends State<DetailAdminCourseScreen> {
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
                  const SizedBox(
                    height: 10,
                  ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: CourseItem(
                            text: widget.course.name!,
                          ),
                        ),
                        Column(
                          children: widget.course.records!
                              .map((courseRecord) => CourseRecordItem(
                                    courseRecord: courseRecord,
                                  ))
                              .toList()
                              .cast<Widget>(),
                        )
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

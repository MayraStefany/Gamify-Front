import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_sliver_app_bar.dart';
import 'package:gamify_app/components/loading_page.dart';
import 'package:gamify_app/models/course.dart';
import 'package:gamify_app/screens/admin/admin_course/components/admin_course_form.dart';
import 'package:gamify_app/services/course_service.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'package:gamify_app/utils/utils.dart';

class NewAdminCourseScreen extends StatefulWidget {
  final Function onRefresh;
  const NewAdminCourseScreen({
    required this.onRefresh,
  });

  @override
  State<NewAdminCourseScreen> createState() => _NewAdminCourseScreenState();
}

class _NewAdminCourseScreenState extends State<NewAdminCourseScreen> {
  final courseService = CourseService.instance;
  bool isShowSpinner = false;

  @override
  Widget build(BuildContext context) {
    return LoadingPage(
      isShowSpinner: isShowSpinner,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              CustomSliverAppBar(),
              SliverFillRemaining(
                child: AdminCourseForm(
                  onGetCourse: (Course course) {
                    registerCourse(course);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerCourse(Course course) async {
    try {
      FocusScope.of(context).unfocus();
      setState(() => isShowSpinner = true);
      await courseService.registerCourse(
        course: course,
      );
      Navigator.pop(context);
      widget.onRefresh();
      Utils.showCustomDialog(
        context: context,
        text: 'Curso registrado con éxito',
      );
    } catch (e) {
      Utils.showCustomDialog(
        context: context,
        text: (e is ServiceException) ? e.message : kMensajeErrorGenerico,
        isError: true,
      );
    } finally {
      setState(() => isShowSpinner = false);
    }
  }
}

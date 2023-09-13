import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/components/custom_text_field.dart';
import 'package:gamify_app/models/course.dart';
import 'package:gamify_app/models/course_record.dart';
import 'package:gamify_app/screens/admin/admin_course/components/course_record_form.dart';
import 'package:gamify_app/services/week_service.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/utils.dart';

class AdminCourseForm extends StatefulWidget {
  final Function onGetCourse;
  const AdminCourseForm({
    required this.onGetCourse,
  });

  @override
  State<AdminCourseForm> createState() => _AdminCourseFormState();
}

class _AdminCourseFormState extends State<AdminCourseForm> {
  final weekService = WeekService.instance;
  final form = GlobalKey<FormState>();
  TextEditingController controllerTitle = TextEditingController(text: '');
  late AutovalidateMode autovalidateMode;
  bool isShowSpinner = false;
  Course? course;
  List<CourseRecord> records = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    setState(() => isShowSpinner = true);
    autovalidateMode = AutovalidateMode.disabled;
    final weeks = await weekService.getWeeks();
    weeks.forEach((week) {
      records.add(
        CourseRecord(
          weekId: week.id,
          topics: [],
          number: week.number,
        ),
      );
    });
    course = Course();
    setState(() => isShowSpinner = false);
  }

  isValidTopicList() {
    bool isValid = false;
    if (records.where((e) => e.topics.isEmpty).isEmpty) {
      isValid = true;
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
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
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 0,
            ),
            child: Text(
              'NUEVO CURSO',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
                fontFamily: kBungeeFont,
                color: kGrayColor,
              ),
              textAlign: TextAlign.center,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Form(
                    key: form,
                    child: Column(
                      children: [
                        CustomTextField(
                          autovalidateMode: autovalidateMode,
                          hintText: 'Título',
                          onChange: (value) => setState(
                            () => controllerTitle.value = TextEditingValue(
                              text: value,
                              selection: controllerTitle.selection,
                            ),
                          ),
                          validator: (value) {
                            String? mensaje;
                            if (value.isEmpty) {
                              mensaje = 'Por favor ingrese el título';
                            }
                            return mensaje;
                          },
                          inputType: TextInputType.text,
                          controller: controllerTitle,
                          color: kGrayColor,
                          borderColor: kGrayColor,
                        ),
                        Column(
                          children: records
                              .map((record) => CourseRecordForm(
                                    text: 'Semana ${record.number}',
                                    onSetTopics: (List<String> topics) {
                                      record.topics = topics;
                                      setState(() {});
                                    },
                                  ))
                              .toList(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          height: 45,
                          onTap: () {
                            if (form.currentState!.validate()) {
                              if (isValidTopicList()) {
                                widget.onGetCourse(getCourse());
                              } else {
                                Utils.showMessage(
                                  context,
                                  'Por favor complete al menos un tema en cada semana',
                                );
                              }
                            } else {
                              setState(
                                () =>
                                    autovalidateMode = AutovalidateMode.always,
                              );
                              Utils.showMessage(
                                context,
                                'Por favor complete todo los campos',
                              );
                            }
                          },
                          child: const Text(
                            'Guardar',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: kGugiFont,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Course getCourse() {
    course?.name = controllerTitle.text;
    course?.records = records;
    return course!;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/components/custom_select.dart';
import 'package:gamify_app/components/custom_text_field.dart';
import 'package:gamify_app/components/date_time_picker.dart';
import 'package:gamify_app/models/course.dart';
import 'package:gamify_app/models/goal.dart';
import 'package:gamify_app/services/course_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/opcion.dart';
import 'package:gamify_app/utils/utils.dart';
import 'package:provider/provider.dart';

class GoalForm extends StatefulWidget {
  final Function onGetGoal;
  const GoalForm({
    required this.onGetGoal,
  });

  @override
  State<GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  final courseService = CourseService.instance;
  final form = GlobalKey<FormState>();
  TextEditingController controllerTitle = TextEditingController(text: '');
  TextEditingController controllerDescription = TextEditingController(text: '');
  DateTime? date;
  late AutovalidateMode autovalidateMode;
  bool isShowSpinner = false;
  Goal? goal;
  String? selectedCourse;
  List<Option> courseOptions = [];
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    setState(() => isShowSpinner = true);
    autovalidateMode = AutovalidateMode.disabled;
    courses = await courseService.getCourses();
    courses.forEach((course) {
      courseOptions.add(Option(text: course.name!, value: course.courseId!));
    });
    goal = Goal();
    setState(() => isShowSpinner = false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  kGoalImagePath,
                  width: 50,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'NUEVO OBJETIVO',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    fontFamily: kBungeeFont,
                    color: kGrayColor,
                  ),
                  textAlign: TextAlign.center,
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
                        CustomTextField(
                          autovalidateMode: autovalidateMode,
                          hintText: 'Descripción',
                          onChange: (value) => setState(
                            () =>
                                controllerDescription.value = TextEditingValue(
                              text: value,
                              selection: controllerDescription.selection,
                            ),
                          ),
                          validator: (value) {
                            String? mensaje;
                            if (value.isEmpty) {
                              mensaje = 'Por favor ingrese la descripción';
                            }
                            return mensaje;
                          },
                          inputType: TextInputType.text,
                          controller: controllerDescription,
                          color: kGrayColor,
                          borderColor: kGrayColor,
                        ),
                        DateTimePicker(
                          helpText: 'Fecha: Fin',
                          dateTime: date,
                          onlyDate: true,
                          onDateTime: (dateTime) {
                            setState(() => date = dateTime);
                          },
                        ),
                        CustomSelect(
                          onChanged: (Option option) {
                            selectedCourse = option.value;
                            setState(() {});
                          },
                          options: courseOptions,
                          title: 'Curso',
                          value: selectedCourse,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          height: 45,
                          onTap: () {
                            if (form.currentState!.validate() &&
                                date != null &&
                                selectedCourse != null) {
                              widget.onGetGoal(getGoal());
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

  Goal getGoal() {
    final user = Provider.of<AppState>(context, listen: false).user;
    goal?.userId = user!.userId;
    goal?.title = controllerTitle.text;
    goal?.description = controllerDescription.text;
    goal?.date = date.toString();
    goal?.course = courses.firstWhere((e) => e.courseId == selectedCourse!);
    return goal!;
  }
}

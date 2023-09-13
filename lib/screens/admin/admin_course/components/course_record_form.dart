import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/components/custom_text_field.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/utils.dart';

class CourseRecordForm extends StatefulWidget {
  final String text;
  final Function onSetTopics;
  const CourseRecordForm({
    required this.text,
    required this.onSetTopics,
  });

  @override
  State<CourseRecordForm> createState() => _CourseRecordFormState();
}

class _CourseRecordFormState extends State<CourseRecordForm> {
  final form = GlobalKey<FormState>();
  List<String> topics = [];
  TextEditingController controllerTopic = TextEditingController(text: '');
  late AutovalidateMode autovalidateMode;

  @override
  void initState() {
    super.initState();
    autovalidateMode = AutovalidateMode.disabled;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: kGrayColor,
                  fontFamily: kRulukoFont,
                ),
              ),
              CustomButton(
                height: 30,
                width: 40,
                onTap: () {
                  if (form.currentState!.validate()) {
                    topics.add(controllerTopic.text);
                    widget.onSetTopics(topics);
                    controllerTopic.clear();
                    autovalidateMode = AutovalidateMode.disabled;
                    setState(() {});
                  } else {
                    setState(
                      () => autovalidateMode = AutovalidateMode.always,
                    );
                    Utils.showMessage(
                      context,
                      'Por favor complete el tema',
                    );
                  }
                },
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: topics
                .map(
                  (topic) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                        height: 15,
                        width: 20,
                        onTap: () {
                          topics.remove(topic);
                          widget.onSetTopics(topics);
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.close,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          topic,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: kRulukoFont,
                            color: kGrayColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextField(
            autovalidateMode: autovalidateMode,
            hintText: 'Tema',
            onChange: (value) => setState(
              () => controllerTopic.value = TextEditingValue(
                text: value,
                selection: controllerTopic.selection,
              ),
            ),
            validator: (value) {
              String? mensaje;
              if (value.isEmpty) {
                mensaje = 'Por favor ingrese el tema';
              }
              return mensaje;
            },
            inputType: TextInputType.text,
            controller: controllerTopic,
            color: kGrayColor,
            borderColor: kGrayColor,
          ),
        ],
      ),
    );
  }
}

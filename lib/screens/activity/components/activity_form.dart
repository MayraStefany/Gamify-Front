import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/components/custom_select.dart';
import 'package:gamify_app/components/custom_text_field.dart';
import 'package:gamify_app/components/date_time_picker.dart';
import 'package:gamify_app/models/event.dart';
import 'package:gamify_app/services/event_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/opcion.dart';
import 'package:gamify_app/utils/utils.dart';
import 'package:provider/provider.dart';

class ActivityForm extends StatefulWidget {
  final String? eventId;
  final Function onGetEvent;
  const ActivityForm({
    this.eventId,
    required this.onGetEvent,
  });

  @override
  State<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final eventService = EventService.instance;
  final form = GlobalKey<FormState>();
  TextEditingController controllerActivityTitle =
      TextEditingController(text: '');
  TextEditingController controllerDescription = TextEditingController(text: '');
  DateTime? startDate;
  DateTime? endDate;
  bool? repeat;
  late AutovalidateMode autovalidateMode;
  bool isShowSpinner = false;
  Event? event;
  String? selectedPriority;
  List<Option> priorityOptions = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    setState(() => isShowSpinner = true);
    autovalidateMode = AutovalidateMode.disabled;
    repeat = false;
    Priority.values.forEach((priority) {
      priorityOptions.add(
        Option(text: priority.text, value: priority.value),
      );
    });
    if (widget.eventId != null) {
      event = await eventService.getEvent(eventId: widget.eventId!);
      controllerActivityTitle = TextEditingController(text: event?.summary);
      controllerDescription = TextEditingController(text: event?.description);
      startDate = DateTime.parse(event!.startDate!);
      endDate = DateTime.parse(event!.endDate!);
      repeat = event?.repeat;
      selectedPriority = event?.priority!.value;
    } else {
      event = Event();
    }
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
                  kNewActivityHeaderImagePath,
                  width: 50,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  (widget.eventId != null)
                      ? 'EDITAR ACTIVIDAD'
                      : 'NUEVA ACTIVIDAD',
                  style: const TextStyle(
                    fontSize: 26,
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
                          hintText: 'Título de actividad',
                          onChange: (value) => setState(
                            () => controllerActivityTitle.value =
                                TextEditingValue(
                              text: value,
                              selection: controllerActivityTitle.selection,
                            ),
                          ),
                          validator: (value) {
                            String? mensaje;
                            if (value.isEmpty) {
                              mensaje =
                                  'Por favor ingrese el título de actividad';
                            }
                            return mensaje;
                          },
                          inputType: TextInputType.text,
                          controller: controllerActivityTitle,
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
                        CustomSelect(
                          onChanged: (Option option) {
                            selectedPriority = option.value;
                            setState(() {});
                          },
                          suffixImage: kPriorityImagePath,
                          options: priorityOptions,
                          title: 'Prioridad',
                          value: selectedPriority,
                        ),
                        DateTimePicker(
                          helpText: 'Fecha - Hora: Inicio',
                          dateTime: startDate,
                          onDateTime: (dateTime) {
                            setState(() => startDate = dateTime);
                          },
                        ),
                        DateTimePicker(
                          helpText: 'Fecha - Hora: Fin',
                          dateTime: endDate,
                          onDateTime: (dateTime) {
                            setState(() => endDate = dateTime);
                          },
                        ),
                        if (widget.eventId == null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() => repeat = !repeat!);
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    width: 25,
                                    height: 25,
                                    child: Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor:
                                              kBackgroundColor),
                                      child: Checkbox(
                                        activeColor: kBackgroundColor,
                                        checkColor: Colors.white,
                                        value: repeat,
                                        onChanged: (value) {
                                          setState(() => repeat = !repeat!);
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Repetir semanalmente',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: kRulukoFont,
                                      color: kGrayColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          height: 45,
                          onTap: () {
                            if (form.currentState!.validate() &&
                                startDate != null &&
                                endDate != null) {
                              if (startDate!.isAfter(endDate!) ||
                                  startDate!.isAtSameMomentAs(endDate!)) {
                                Utils.showMessage(
                                  context,
                                  'Las fecha final debe ser mayor a la fecha inicio',
                                );
                              } else {
                                widget.onGetEvent(getEvent());
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

  Event getEvent() {
    final user = Provider.of<AppState>(context, listen: false).user;
    event?.summary = controllerActivityTitle.text;
    event?.description = controllerDescription.text;
    event?.startDate = startDate.toString();
    event?.endDate = endDate.toString();
    event?.priority = Utils.enumFromString(selectedPriority!, Priority.values);
    event?.user = user!.userId;
    event?.repeat = repeat;
    return event!;
  }
}

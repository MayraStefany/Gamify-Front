import 'package:flutter/material.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final String helpText;
  final DateTime? dateTime;
  final Function onDateTime;
  final bool onlyDate;
  const DateTimePicker({
    required this.helpText,
    this.dateTime,
    required this.onDateTime,
    this.onlyDate = false,
  });

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = widget.dateTime;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 10,
      ),
      child: GestureDetector(
        onTap: () async {
          if (widget.onlyDate) {
            dateTime = await pickDate(widget.helpText);
            if (dateTime == null) return;
            widget.onDateTime(dateTime);
          } else {
            pickDateTime(widget.helpText);
          }
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(
              color: kGrayColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                Image.asset(
                  kCalendarMenuImagePath,
                  height: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    dateTime != null
                        ? DateFormat(widget.onlyDate
                                ? 'dd/MM/yyyy'
                                : 'dd/MM/yyyy hh:mm a')
                            .format(dateTime!)
                        : widget.helpText,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: kRulukoFont,
                      color: kGrayColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickDateTime(String helpText) async {
    DateTime? date = await pickDate(helpText);
    if (date == null) return;
    TimeOfDay? time = await pickTime(helpText);
    if (time == null) return;
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() => this.dateTime = dateTime);
    widget.onDateTime(dateTime);
  }

  Future<DateTime?> pickDate(String helpText) => showDatePicker(
        helpText: helpText,
        context: context,
        initialDate: dateTime ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.black.withOpacity(0.8),
              ),
            ),
            child: child!,
          );
        },
      );

  Future<TimeOfDay?> pickTime(String helpText) => showTimePicker(
        helpText: helpText,
        context: context,
        initialTime: TimeOfDay(
          hour: dateTime != null ? dateTime!.hour : DateTime.now().hour,
          minute: dateTime != null ? dateTime!.minute : DateTime.now().minute,
        ),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.black.withOpacity(0.8),
              ),
            ),
            child: child!,
          );
        },
      );
}

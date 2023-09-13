import 'package:flutter/material.dart';
import 'package:gamify_app/models/event.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/utils.dart';
import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
  final Event event;
  const EventItem({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = Color(0xFF878383);
    return Container(
      height: 160,
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
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              color: Utils.getColorByPriority(event.priority),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${event.summary}',
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
                    Text(
                      '.  ${event.description ?? '-'}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: kRulukoFont,
                        color: kGrayColor,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '.  ${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(event.startDate!))}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: kRulukoFont,
                        color: kGrayColor,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '.  ${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(event.endDate!))}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: kRulukoFont,
                        color: kGrayColor,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '.  Prioridad: ${Utils.getTextPriority(event.priority)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: kRulukoFont,
                        color: kGrayColor,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '.  Puntos: ${event.points}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: kRulukoFont,
                        color: kGrayColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

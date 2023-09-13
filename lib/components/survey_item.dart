import 'package:flutter/material.dart';
import 'package:gamify_app/utils/constans.dart';

class SurveyItem extends StatefulWidget {
  final String text;
  final Function onTap;
  final double? fontSizeText;
  const SurveyItem({
    required this.text,
    required this.onTap,
    this.fontSizeText,
  });

  @override
  State<SurveyItem> createState() => _SurveyItemState();
}

class _SurveyItemState extends State<SurveyItem> {
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.fontSizeText ?? 18,
            fontWeight: FontWeight.w400,
            fontFamily: kRulukoFont,
            color: kGrayColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '‘1 - Muy deficiente',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: kRulukoFont,
                      color: kGrayColor,
                    ),
                  ),
                  Text(
                    '‘5 - Excelente',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: kRulukoFont,
                      color: kGrayColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SurveyOption(
                      value: 1,
                      selectedValue: selectedValue,
                      onTap: () {
                        setState(() => selectedValue = 1);
                        widget.onTap(selectedValue);
                      },
                    ),
                    SurveyOption(
                      value: 2,
                      selectedValue: selectedValue,
                      onTap: () {
                        setState(() => selectedValue = 2);
                        widget.onTap(selectedValue);
                      },
                    ),
                    SurveyOption(
                      value: 3,
                      selectedValue: selectedValue,
                      onTap: () {
                        setState(() => selectedValue = 3);
                        widget.onTap(selectedValue);
                      },
                    ),
                    SurveyOption(
                      value: 4,
                      selectedValue: selectedValue,
                      onTap: () {
                        setState(() => selectedValue = 4);
                        widget.onTap(selectedValue);
                      },
                    ),
                    SurveyOption(
                      value: 5,
                      selectedValue: selectedValue,
                      onTap: () {
                        setState(() => selectedValue = 5);
                        widget.onTap(selectedValue);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SurveyOption extends StatelessWidget {
  final int value;
  final int? selectedValue;
  final Function onTap;
  const SurveyOption({
    required this.value,
    this.selectedValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 50,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            width: 2,
            color: Color(0xFF676565),
          ),
          color: selectedValue == value ? Color(0xFF495F75) : Colors.black,
        ),
        child: Center(
          child: Text(
            '$value',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: kGrayColor,
            ),
          ),
        ),
      ),
    );
  }
}

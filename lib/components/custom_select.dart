import 'package:flutter/material.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/opcion.dart';

class CustomSelect extends StatefulWidget {
  final String title;
  final String? value;
  final List<Option> options;
  final Function onChanged;
  final String? suffixImage;

  CustomSelect({
    required this.title,
    this.value,
    required this.options,
    required this.onChanged,
    this.suffixImage,
  });

  @override
  _CustomSelectState createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {
  late List<Option> options;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    options = (widget.value != null)
        ? widget.options.where((e) => e.value != widget.value).toList()
        : widget.options;
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 10,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(
              () => _isExpanded = !_isExpanded,
            ),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              constraints: const BoxConstraints(minHeight: 45),
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
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    if (widget.suffixImage != null) ...[
                      Image.asset(
                        widget.suffixImage!,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                    Expanded(
                      child: (widget.value != null &&
                              widget.options
                                  .where(
                                      (option) => option.value == widget.value)
                                  .toList()
                                  .isNotEmpty)
                          ? Text(
                              widget.options
                                  .where(
                                      (option) => option.value == widget.value)
                                  .first
                                  .text,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: kRulukoFont,
                                color: kGrayColor,
                              ),
                            )
                          : Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: kRulukoFont,
                                color: kGrayColor,
                              ),
                            ),
                    ),
                    const Icon(
                      Icons.menu_rounded,
                      size: 30,
                      color: kGrayColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isExpanded) ...[
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                border: Border.all(
                  color: kGrayColor,
                ),
              ),
              child: SizedBox(
                height: widget.options.length * 37.0 > 250
                    ? 250
                    : widget.options.length * 37.0 -
                        (widget.value != null ? 37 : 0),
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        InkWell(
                          splashColor: Colors.black26,
                          onTap: () {
                            _isExpanded = false;
                            widget.onChanged(options[index]);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 37,
                            child: Text(
                              options[index].text,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: kRulukoFont,
                                color: kGrayColor,
                              ),
                            ),
                          ),
                        ),
                        if (index != options.length - 1)
                          const Divider(
                            color: kGrayColor,
                            height: 0,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

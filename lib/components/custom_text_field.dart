import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamify_app/utils/styles.dart';

class CustomTextField extends StatefulWidget {
  final String? prefixImage;
  final String? text;
  final Function? onChange;
  final bool obscureText;
  final TextInputType? inputType;
  final bool passwordFunction;
  final bool enabled;
  final Function? validator;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController controller;
  final int? maxLength;
  final Color? color;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? hintText;
  final FocusNode? focusNode;
  final Color? borderColor;

  CustomTextField({
    this.prefixImage,
    this.text,
    this.onChange,
    this.obscureText = false,
    this.inputType,
    this.passwordFunction = false,
    this.enabled = true,
    this.validator,
    this.autovalidateMode,
    required this.controller,
    this.maxLength,
    this.color,
    this.floatingLabelBehavior,
    this.hintText,
    this.focusNode,
    this.borderColor,
  });
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.floatingLabelBehavior != null ? 0 : 8.0,
        bottom: 10,
      ),
      child: TextFormField(
        style: TextStyle(
          color: widget.color ?? Color(0xFFA9DF9C),
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        inputFormatters: (widget.maxLength != null)
            ? [LengthLimitingTextInputFormatter(widget.maxLength)]
            : [],
        focusNode: widget.focusNode,
        textAlign: TextAlign.justify,
        keyboardType: widget.inputType ?? TextInputType.text,
        obscureText: obscure,
        enabled: widget.enabled,
        validator: (value) {
          return widget.validator != null ? widget.validator!(value) : null;
        },
        onTapOutside: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        autovalidateMode: widget.autovalidateMode,
        decoration: kTextFieldDecoration.copyWith(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: widget.borderColor ?? Color(0xFFA9DF9C),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: widget.borderColor ?? Color(0xFFA9DF9C),
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: widget.color ?? Color(0xFFA9DF9C),
          ),
          errorStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          prefixIcon: widget.prefixImage != null
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    widget.prefixImage!,
                    height: 5,
                  ),
                )
              : null,
          labelText: widget.text,
          floatingLabelBehavior:
              widget.floatingLabelBehavior ?? FloatingLabelBehavior.always,
          suffixIcon: widget.passwordFunction
              ? GestureDetector(
                  child: Icon(
                    obscure ? Icons.visibility_off : Icons.visibility,
                    color: widget.color ?? Theme.of(context).primaryColor,
                  ),
                  onTap: () {
                    setState(() => obscure = !obscure);
                  },
                )
              : null,
        ),
        controller: widget.controller,
        onChanged: (value) => widget.onChange!(value),
      ),
    );
  }
}

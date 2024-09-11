import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:flutter/services.dart';
import '../styles/app_colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    this.preFilledValue,
    this.passwordField = false,
    this.hintText,
    this.width,
    this.validator,
    this.keyboardType,
    this.readOnly = false,
    this.inputFormatters,
    this.isDateField = false,
    this.onSubmit,
    this.maxLength,
    this.textEditingController,
    this.suffixIcon,
    this.onCrossTap,
    this.showCrossIcon = false,
    required this.onChanged,
  });
  final List<TextInputFormatter>? inputFormatters;
  final String? preFilledValue;
  final bool passwordField;
  final int? maxLength;
  final bool isDateField;
  final bool readOnly;
  final String? hintText;
  final bool showCrossIcon;
  final double? width;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final void Function()? onCrossTap;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  final void Function(String)? onSubmit;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late TextEditingController controller;
  bool isObsecure = true;

  @override
  void initState() {
    super.initState();
    if (widget.textEditingController != null) {
      controller = widget.textEditingController!;
    } else {
      controller = TextEditingController();
    }
    if (widget.preFilledValue != null) {
      controller.text = '${widget.preFilledValue}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          keyboardType: widget.keyboardType,
          controller: controller,
          style: Styles.mediumStyle(fontSize: 15, color: AppColor.black1),
          inputFormatters: widget.inputFormatters,
          obscureText: widget.passwordField ? isObsecure : false,
          readOnly: widget.readOnly,
          cursorColor: AppColor.black1,
          cursorErrorColor: AppColor.black1,
          onChanged: widget.onChanged,
          validator: widget.validator,
          onTap: () {},
          maxLength: widget.maxLength,
          scrollPadding: const EdgeInsets.all(0),
          onFieldSubmitted: widget.onSubmit,
          decoration: Styles.inputFieldDecoration(
            widget.hintText ?? '',
            context,
            suffixIcon: widget.passwordField
                ? GestureDetector(
                    onTap: () {
                      isObsecure = !isObsecure;
                      setState(() {});
                    },
                    child: Icon(
                      isObsecure
                          ? Icons.visibility_off
                          : Icons.remove_red_eye_rounded,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ))
                : widget.showCrossIcon
                    ? GestureDetector(
                        onTap: () {
                          widget.onCrossTap?.call();
                        },
                        child: const Icon(Icons.cancel))
                    : null,
          )),
    );
  }
}

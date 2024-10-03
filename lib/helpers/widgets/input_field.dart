import 'dart:developer';

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
    this.validator,
    this.keyboardType,
    this.readOnly = false,
    this.inputFormatters,
    this.isDateField = false,
    this.focusNode,
    this.onSubmit,
    this.maxLength,
    this.textEditingController,
    this.suffixIcon,
    this.onCrossTap,
    this.borderRadius,
    this.showCrossIcon = false,
    this.disableOnTapOutside = false,
    required this.onChanged,
  });
  final List<TextInputFormatter>? inputFormatters;
  final String? preFilledValue;
  final bool disableOnTapOutside;
  final bool passwordField;
  final int? maxLength;
  final bool isDateField;
  final bool readOnly;
  final String? hintText;
  final bool showCrossIcon;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final double? borderRadius;
  final Widget? suffixIcon;
  final void Function()? onCrossTap;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  final void Function(String)? onSubmit;
  final FocusNode? focusNode;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late TextEditingController controller;
  bool isObsecure = true;

  @override
  void initState() {
    log("${widget.preFilledValue}");
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
  void dispose() {
    widget.focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: widget.focusNode,
        onTapOutside: (event) {
          if (!widget.disableOnTapOutside) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        keyboardType: widget.keyboardType,
        controller: controller,
        style: Styles.semiMediumStyle(
          fontSize: 15,
          color: AppColor.black1,
          family: FontFamily.varela,
        ),
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
        decoration: InputDecoration(
          hintText: widget.hintText,
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
          fillColor: AppColor.lightGrey,
          errorStyle: Styles.boldStyle(
              fontSize: 12, color: AppColor.red, family: FontFamily.varela),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.red,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          errorMaxLines: 1,
          contentPadding: const EdgeInsets.all(8),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.red,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          hintStyle: Styles.mediumStyle(
              fontSize: 15, color: AppColor.grey, family: FontFamily.varela),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.black1,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.black1,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
        ));
  }
}

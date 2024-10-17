import '../../../helpers/extensions.dart';
import '../../../helpers/styles/styles.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

import '../../../helpers/styles/app_colors.dart';

class IssueField extends StatefulWidget {
  const IssueField({
    super.key,
    required this.hintText,
    this.width,
    this.validator,
    this.inputFormatters,
    this.maxLength,
    this.focusNode,
    this.textEditingController,
    required this.onChanged,
    required this.cursorSize,
    required this.hintStyle,
    required this.textStyle,
  });
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final String hintText;
  final Size cursorSize;
  final double? width;
  final TextStyle hintStyle;
  final FocusNode? focusNode;
  final TextStyle textStyle;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  @override
  State<IssueField> createState() => _IssueFieldState();
}

class _IssueFieldState extends State<IssueField> {
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
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: widget.textStyle,
      controller: controller,
      focusNode: widget.focusNode,
      inputFormatters: widget.inputFormatters,
      cursorColor: context.colorScheme.onPrimary,
      cursorHeight: widget.cursorSize.height,
      cursorWidth: widget.cursorSize.width,
      cursorErrorColor: context.colorScheme.onPrimary,
      onChanged: widget.onChanged,
      validator: widget.validator,
      minLines: 1,
      maxLines: widget.maxLength,
      scrollPadding: const EdgeInsets.all(0),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.hintText,
        fillColor: context.colorScheme.onPrimary,
        errorStyle: Styles.boldStyle(
          fontSize: 12,
          color: AppColor.red,
          family: FontFamily.varela,
        ),
        errorBorder: InputBorder.none,
        errorMaxLines: 1,
        contentPadding: const EdgeInsets.all(0),
        focusedErrorBorder: InputBorder.none,
        hintStyle: widget.hintStyle,
      ),
    );
  }
}

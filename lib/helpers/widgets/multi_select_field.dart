import 'package:flutter/material.dart';
import '../styles/styles.dart';
import 'package:multiselect/multiselect.dart';

class MultiSelectField extends StatefulWidget {
  const MultiSelectField({
    super.key,
    this.title,
    required this.onChanged,
    required this.dropdownItems,
    this.preFilledText,
    this.readOnly = false,
    required this.selectedValues,
  });

  final Function(List<dynamic>)? onChanged;
  final List<dynamic>? dropdownItems;
  final String? title;
  final List<String>? preFilledText;
  final List<String> selectedValues;
  final bool readOnly;
  @override
  State<MultiSelectField> createState() => _MultiSelectFieldState();
}

class _MultiSelectFieldState extends State<MultiSelectField> {
  String? displayedText;

  @override
  void initState() {
    super.initState();
    updateDisplayedText();
  }

  void updateDisplayedText() {
    if (widget.selectedValues.isEmpty) {
      displayedText = '    Select Items';
    } else if (widget.selectedValues.length <= 3) {
      displayedText = widget.selectedValues
          .map((e) => e.toString())
          .reduce((a, b) => '$a , $b');
    } else {
      displayedText =
          '${widget.selectedValues[0]} ,${widget.selectedValues[1]}, ' '...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: Center(
            child: DropDownMultiSelect(
              readOnly: widget.readOnly,
              decoration: Styles.inputFieldDecoration(
                widget.title ?? "",
                context,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 35,
                color: Theme.of(context).colorScheme.primary,
              ),
              childBuilder: displayedText != null
                  ? (selectedValues) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 120),
                        child: Text(displayedText!),
                      );
                    }
                  : null,
              options: widget.dropdownItems ?? [],
              selectedValues: widget.selectedValues,
              onChanged: (value) {
                widget.onChanged?.call(value);
                updateDisplayedText();
              },
            ),
          ),
        ),
      ),
    );
  }
}

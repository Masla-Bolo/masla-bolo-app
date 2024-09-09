import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';

import '../styles/app_colors.dart';

class DropDownField extends StatefulWidget {
  const DropDownField({
    super.key,
    this.title,
    required this.onChanged,
    required this.dropdownItems,
    this.preFilledVal,
    this.width,
  });
  final Function(String)? onChanged;
  final List<String>? dropdownItems;
  final String? title;
  final double? width;
  final String? preFilledVal;
  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState<T> extends State<DropDownField> {
  String? valueSelected;
  @override
  void initState() {
    super.initState();
    if (widget.dropdownItems!.isNotEmpty) {
      if (widget.preFilledVal != null) {
        valueSelected = widget.preFilledVal;
      } else {
        valueSelected = widget.dropdownItems![0];
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onChanged!(valueSelected ?? "");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          height: 70,
          width: widget.width ?? 0.51.sw,
          child: Column(
            children: [
              12.verticalSpace,
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: DropdownButtonFormField2<String>(
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColor.black1,
                        width: 0.5,
                      ),
                    ),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    iconSize: 30,
                    iconDisabledColor: AppColor.black1,
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration:
                      Styles.inputFieldDecoration(widget.title ?? "", context),
                  value: valueSelected,
                  hint: const Text('Select an item'),
                  items: _buildDropdownItems(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        widget.onChanged?.call(value);
                        valueSelected = value;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    if (widget.dropdownItems == null) {
      return [
        const DropdownMenuItem<String>(
          value: null,
          child: Text(
            'Empty',
          ),
        ),
      ];
    }

    return widget.dropdownItems?.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                item.toString(),
              ),
            ),
          );
        }).toList() ??
        [];
  }
}

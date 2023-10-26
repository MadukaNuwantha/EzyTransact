import 'package:ezytransact/constants.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final List<String> itemList;
  const CustomDropdownField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.itemList,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: kLightAccentColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kLightAccentColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kLightAccentColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kLightAccentColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kLightAccentColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kLightAccentColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        label: Text(widget.labelText),
        labelStyle: TextStyle(
          color: kLightAccentColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      iconDisabledColor: kLightAccentColor,
      iconEnabledColor: kLightAccentColor,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      value: widget.controller.text.isNotEmpty ? widget.controller.text : null,
      items: widget.itemList.map<DropdownMenuItem<String>>(
        (String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        },
      ).toList(),
      onChanged: (String? value) {
        widget.controller.text = value!;
      },
      validator: (value) {
        if (widget.controller.text.isEmpty) {
          return 'Please fill this field to continue';
        } else {
          return null;
        }
      },
    );
  }
}

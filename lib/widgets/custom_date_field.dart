import 'package:ezytransact/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  const CustomDateField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kPrimaryColor,
            hintColor: kPrimaryColor,
            colorScheme: ColorScheme.light(
              primary: kPrimaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked.toString() != widget.controller.text) {
      setState(
        () {
          widget.controller.text =
              DateFormat('dd-MM-yyyy').format(picked).toString();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
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
        suffixIcon: Icon(
          Icons.calendar_month_rounded,
          color: kLightAccentColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      cursorColor: kDarkAccentColor,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: () => _selectDate(context),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill this field to continue';
        } else {
          return null;
        }
      },
    );
  }
}

import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;

  const CustomDatePicker({
    super.key,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  String buttonText = "No of days";

  Future<void> _pickDateRange(BuildContext context) async {
    final DateTime now = DateTime.now();

    final DateTimeRange? pickedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5), // Adjust to your needs
      lastDate: DateTime(now.year + 5), // Adjust to your needs
    );

    if (pickedRange != null) {
      final int difference = pickedRange.end.difference(pickedRange.start).inDays + 1;

      setState(() {
        buttonText = "$difference day(s)";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () => _pickDateRange(context),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 0,
          backgroundColor: widget.backgroundColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: widget.textColor,
          ),
        ),
      ),
    );
  }
}

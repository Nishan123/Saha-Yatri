import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> options; // List of options passed to the widget
  final String? initialValue; // Optional initial value
  final void Function(String)? onChanged; // Optional callback for value change

  const CustomDropdown({
    Key? key,
    required this.options, // Ensure options are required
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedValue; // State variable for selected value

  @override
  void initState() {
    super.initState();
    // Set initial value or fallback to the first option
    selectedValue = widget.initialValue ?? widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(14),
      ),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 40),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onSelected: (value) {
          setState(() {
            selectedValue = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value); // Notify parent if callback is provided
          }
        },
        itemBuilder: (BuildContext context) {
          return widget.options
              .map((option) => PopupMenuItem(
                    value: option,
                    child: Text(option),
                  ))
              .toList();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedValue,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

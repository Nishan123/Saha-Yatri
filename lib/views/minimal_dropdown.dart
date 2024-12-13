import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({Key? key}) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String selectedValue = "One"; // Default value

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
        },
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              value: "One",
              child: const Text("One"),
            ),
            PopupMenuItem(
              value: "Two",
              child: const Text("Two"),
            ),
            PopupMenuItem(
              value: "Three",
              child: const Text("Three"),
            ),
          ];
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

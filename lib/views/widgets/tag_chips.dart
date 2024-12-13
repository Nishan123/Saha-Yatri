import 'package:flutter/material.dart';

class TagChips extends StatelessWidget {
  final List<String> tags;
  const TagChips({
    super.key,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // Horizontal spacing between chips
      runSpacing: 4.0, // Vertical spacing between rows
      children: tags.map((tag) {
        return Chip(
          label: Text(
            tag,
            style: const TextStyle(color: Colors.white), // Text color
          ),
          backgroundColor: Colors.blue, // Chip background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
        );
      }).toList(),
    );
  }
}

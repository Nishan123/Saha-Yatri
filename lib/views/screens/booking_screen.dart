import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:saha_yatri/views/minimal_dropdown.dart';
import 'package:saha_yatri/views/theme/custom_text_style.dart';
import 'package:saha_yatri/views/widgets/custom_button.dart';
import 'package:saha_yatri/views/widgets/custom_date_picker.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String dropdownValue = "One";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking a guide's name"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Guides name",
                      style: CustomTextStyle.heading2,
                    ),
                    DetailsWidget(
                      text: "Experience",
                      icon: FeatherIcons.clock,
                    ),
                    Text(
                      "Pricing",
                      style: CustomTextStyle.price,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            const Text(
              "Enter details",
              style: CustomTextStyle.heading2,
            ),
            CustomDropdown(),
            CustomDropdown(),
            CustomDropdown(),
            const SizedBox(
              height: 10,
            ),
            const CustomDatePicker(
              backgroundColor: Colors.black54,
              textColor: Colors.white,
            ),
            const Spacer(),
            CustomButton(
                backgroundColor: Colors.black,
                onPressed: () {},
                text: "Confirm Booking",
                textColor: Colors.white),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      )),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const DetailsWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
        ),
        Text(text),
      ],
    );
  }
}

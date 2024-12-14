import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:random_string/random_string.dart';
import 'package:saha_yatri/services/auth_service.dart';
import 'package:saha_yatri/services/booking_service.dart';
import 'package:saha_yatri/views/minimal_dropdown.dart';
import 'package:saha_yatri/views/theme/custom_text_style.dart';
import 'package:saha_yatri/views/widgets/custom_button.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String selectedDestination = "Bouddhanath Stupa";
  String selectedNoOfPeople = "1";
  String selectedLanguage = "English";
  String phone = "";
  String client_name = "";
  final AuthService _authService = AuthService();

  Future<void> fetchAndSetUserData() async {
    try {
      String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      Map<String, dynamic>? userData =
          await _authService.fetchUserData(uid: currentUserUid);

      setState(() {
        if (mounted) {
          setState(() {
            phone = userData!['phone'] ?? 'Not Available';
            client_name = userData['name'] ?? 'Not Available';
          });
        }
      });
    } catch (e) {
      _authService.showToast(
          "Unknown error occurred", Colors.red, Colors.white);
    }
  }

  @override
  void initState() {
    fetchAndSetUserData();
    super.initState();
  }

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
            const Text("Destination name"),
            const CustomBox(),
            CustomDropdown(
              onChanged: (newValue) {
                selectedDestination = newValue;
              },
              options: const [
                "Bouddhanath Stupa",
                "Bhaktapur Durbar Square",
                "Basantapur Darbar Square",
              ],
              initialValue: "Bouddhanath Stupa",
            ),
            const CustomBox(),
            const Text("No of people"),
            CustomDropdown(
              onChanged: (newValue) {
                selectedNoOfPeople = newValue;
              },
              options: const [
                "1",
                "2-5",
                "5-7",
                "7-10",
              ],
              initialValue: "1",
            ),
            const CustomBox(),
            const Text("Language"),
            CustomDropdown(
              onChanged: (newValue) {
                selectedLanguage = newValue;
              },
              options: const [
                "Chinease",
                "Hindi",
                "English",
                "Spanish",
              ],
              initialValue: "English",
            ),
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
                onPressed: () {
                  String bookingId = randomAlphaNumeric(6);
                  Map<String, dynamic> bookingMap = {
                    "client_name": client_name,
                    "destination": selectedDestination,
                    "phone": phone,
                    "no_of_people": selectedNoOfPeople,
                  };
                  BookingService().bookRequest(bookingMap, bookingId);
                },
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
      final int difference =
          pickedRange.end.difference(pickedRange.start).inDays + 1;

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

class CustomBox extends StatelessWidget {
  const CustomBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 8,
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

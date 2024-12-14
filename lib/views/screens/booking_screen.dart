import 'package:cloud_firestore/cloud_firestore.dart';
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
  String clientId = "";
  String clientName = "";
  DateTime? startDate; // To store the selected start date
  DateTime? endDate; // To store the selected end date

  final AuthService _authService = AuthService();

  Future<void> fetchAndSetUserData() async {
    try {
      // Get the current user UID from Firebase Authentication
      String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

      // Fetch user data from Firestore 'user' collection, using the current user's UID
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(
              'users') // Replace 'users' with your actual Firestore collection name
          .doc(currentUserUid)
          .get();

      if (userDoc.exists) {
        // Extract the data from the document
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>;

        // Update state with user data
        setState(() {
          if (mounted) {
            phone = userData['phone'] ?? 'Not Available';
            clientName = userData['username'] ?? 'Not Available';
            clientId =
                userData['uid'] ?? 'N/A'; // Adjust the field name as needed
          }
        });
      } else {
        // Handle case where the document doesn't exist
        _authService.showToast(
            "User document does not exist", Colors.red, Colors.white);
      }
    } catch (e) {
      // Handle any errors
      _authService.showToast(
          "Unknown error occurred: $e", Colors.red, Colors.white);
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
                      "\$50 per day",
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
            CustomDatePicker(
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              onDateSelected: (DateTime start, DateTime end) {
                setState(() {
                  startDate = start;
                  endDate = end;
                });
              },
            ),
            const Spacer(),
            CustomButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  String bookingId = randomAlphaNumeric(6);

                  // Format the selected date range as a string
                  String dateRange = startDate != null && endDate != null
                      ? "${startDate!.day}/${startDate!.month}/ - ${endDate!.day}/${endDate!.month}/"
                      : "Not selected";

                  Map<String, dynamic> bookingMap = {
                    "client_name": clientName,
                    "clientId": clientId,
                    "language": selectedLanguage,
                    "destination": selectedDestination,
                    "phone": phone,
                    "no_of_people": selectedNoOfPeople,
                    "date": dateRange,
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
  final Function(DateTime startDate, DateTime endDate)? onDateSelected;

  const CustomDatePicker({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    this.onDateSelected,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  String buttonText = "No of days";
  String? price;

  Future<void> _pickDateRange(BuildContext context) async {
    final DateTime now = DateTime.now();

    final DateTimeRange? pickedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5), // Adjust to your needs
      lastDate: DateTime(now.year + 5), // Adjust to your needs
    );

    if (pickedRange != null) {
      final DateTime startDate = pickedRange.start;
      final DateTime endDate = pickedRange.end;

      final int difference = endDate.difference(startDate).inDays + 1;

      setState(() {
        buttonText =
            "${_formatDate(startDate)} till ${_formatDate(endDate)} = $difference day(s)";
      });

      // Trigger the callback to pass the selected dates to the parent widget
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(startDate, endDate);
      }
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
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

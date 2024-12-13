import 'package:flutter/material.dart';
import 'package:saha_yatri/views/screens/booking_screen.dart';
import 'package:saha_yatri/views/theme/custom_text_style.dart';
import 'package:saha_yatri/views/widgets/custom_button.dart';
import 'package:saha_yatri/views/widgets/known_destinations.dart';
import 'package:saha_yatri/views/widgets/tag_chips.dart';

class GuidesProfile extends StatelessWidget {
  const GuidesProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    const SizedBox(width: 10), // Add spacing between elements
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Guide's name",
                          style: CustomTextStyle.heading,
                        ),
                        Text("Available status"),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                            ),
                            SizedBox(width: 5), // Add spacing
                            Text("Experience"),
                          ],
                        ),
                        Text(
                          "Pricing",
                          style: CustomTextStyle.price,
                        )
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Text(
                  "Guides Bio dksbfak dfkasdjf aksd vkjasd fkv sdkv smd vksa dvlka sdvk askd vksd v dskv kdfj vkasj dkwaoergerbalsdv lv alsd fb sht se df as fd asg s dag e thq arh eag sd g ad f as dga rrg sdfg da g adsg sdf hg sd fh sdr",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Divider(),
                const Text("Speaks 🗣️", style: CustomTextStyle.heading),
                const TagChips(tags: [
                  "Nepali",
                  "Hindi",
                  "English",
                  "Korean",
                  "Japanese",
                  "Jamali"
                ]),
                const Divider(),
                const Text(
                  "Extras ⭐",
                  style: CustomTextStyle.heading,
                ),
                const TagChips(tags: [
                  "Story teller",
                  "Funny",
                  "Helper",
                  "Something random",
                  "Another random",
                  "Well deserved"
                ]),
                const Divider(),
                const Text(
                  "Known Destinations 🌄",
                  style: CustomTextStyle.heading,
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(10, (index) {
                      return const KnownDestinations();
                    }),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BookingScreen()),
                    );
                  },
                  text: "Book a Guide",
                  textColor: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 0.5,
      color: Colors.black45,
    );
  }
}

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
                      child:ClipRRect(
                        child:Image.asset('assets/dad.jpg')
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
                  "Eexperienced Nepali trekking guide with over 10 years of guiding trekkers through the Himalayas. Passionate about Nepal's natural beauty, he offers in-depth knowledge of trails, culture, and safety. With a friendly demeanor and expert navigation skills, Ramesh ensures every trekker enjoys an unforgettable adventure.",
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
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      KnownDestinations(
                        image: 'assets/god.jpg',
                        name: 'Boudhanath Stupa',
                      ),
                      KnownDestinations(
                        image: 'assets/temple.jpg',
                        name: 'Pashupatinath temple',
                      ),
                      KnownDestinations(
                        image: 'assets/garden.jpg',
                        name: 'Godawari garden',
                      ),
                    ],
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

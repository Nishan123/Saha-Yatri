import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:saha_yatri/services/auth_service.dart';
import 'package:saha_yatri/services/geo_service.dart';
import 'package:saha_yatri/views/widgets/choice_chip.dart';
import 'package:saha_yatri/views/widgets/current_location_widget.dart';
import 'package:saha_yatri/views/widgets/destination_card.dart';
import 'package:saha_yatri/views/widgets/home_appbar.dart';
import 'package:saha_yatri/views/widgets/search_bar_field.dart';
import 'package:saha_yatri/views/widgets/top_guides.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "Loading..";
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    fetchAndSetUserData();
  }

  // Loading data from Firestore database
  Future<void> fetchAndSetUserData() async {
    try {
      String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      Map<String, dynamic>? userData =
          await _authService.fetchUserData(uid: currentUserUid);

      setState(() {
        username = userData!['username'] ?? 'Guest';
      });
    } catch (e) {
      _authService.showToast(
          "Unknown error occurred", Colors.red, Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: HomeAppbar(
        username: username,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: ListView(
            clipBehavior: Clip.none,
            children: [
              CurrentLocationWidget(
                locationData: GeoService().getLocation(),
              ),
              SearchBarField(
                hintText: "Search your Saha-Yatri / destination",
                controller: searchController,
                prefixIcon: const Icon(FeatherIcons.search),
              ),
              const TopGuides(),
              const SizedBox(height: 10),
              const CustomChoiceChip(),
              ListView.builder(
                clipBehavior: Clip.none,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const DestinationCard(
                    destinationName: 'Bhaktapur Darbar Square',
                    destinationAddress: "Bhaktapur Darbar area",
                    distance: "16 Km away",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

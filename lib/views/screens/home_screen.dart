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
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "Loading..";
  List<dynamic> destinations = [];
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    fetchAndSetUserData();
    fetchDestinations();
  }

  // Fetch data from the API
  Future<void> fetchDestinations() async {
    const String apiUrl =
        "https://script.googleusercontent.com/macros/echo?user_content_key=IU9F1Lc33810l0uA1PGT8sGOhRW3wcn2hK81C7oHQyZrQgQI7scj4bUmJVBVA-sNb88zJG0wHTHbyxAsADx3IOw4mpoITaWTm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnHuIHL5OsL_4ctSPHtYaRvx0tL0oe2oDLMGykNkHNhGIZ5Ikn2d_HsA25h2q5EW7uBAVfX9VwnI23W6FOcx-WPogtxiUk1bZRQ&lib=Mjl9x6d0obvhsda87gAiPP80BbcbIvll7";
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          if (mounted) {
            setState(() {
              destinations = data['data'];
            });
          }
        });
      } else {
        throw Exception('Failed to fetch destinations');
      }
    } catch (e) {
      setState(() {
        destinations = [];
      });
    }
  }

  // Loading data from Firestore database
  Future<void> fetchAndSetUserData() async {
    try {
      String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      Map<String, dynamic>? userData =
          await _authService.fetchUserData(uid: currentUserUid);

      setState(() {
        if (mounted) {
          setState(() {
            username = userData!['username'] ?? 'Guest';
          });
        }
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
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CurrentLocationWidget(locationData: GeoService().getLocation()),
                const SizedBox(height: 10),
                SearchBarField(
                  hintText: "Search your Saha-Yatri / destination",
                  controller: searchController,
                  prefixIcon: const Icon(FeatherIcons.search),
                ),
                const SizedBox(height: 10),
                const TopGuides(),
                const SizedBox(height: 10),
                const CustomChoiceChip(),
                const SizedBox(height: 10),
                // Wrap ListView.builder in a fixed-height Container
                destinations.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        clipBehavior: Clip.none,
                        itemCount: destinations.length,
                        itemBuilder: (context, index) {
                          final destination = destinations[index];
                          return DestinationCard(
                            image: destination['imageUrl'],
                            destinationName: destination['destination'],
                            destinationAddress: destination['location'],
                            distance: destination['distance'],
                            tags: destination['tags'],
                            latLong: destination['latitude_longitude'].toString(),
                            description: destination['description'],
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

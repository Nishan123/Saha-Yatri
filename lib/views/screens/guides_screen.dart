import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:saha_yatri/views/widgets/guide_card.dart';
import 'package:saha_yatri/views/widgets/search_bar_field.dart';

class GuidesScreen extends StatelessWidget {
  const GuidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saha-Yatri"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            clipBehavior: Clip.none,
            children: [
              SearchBarField(
                hintText: "Search your Saha-Yatri / destination",
                controller: searchController,
                 prefixIcon: const Icon(FeatherIcons.search),
              ),
              ListView.builder(
                clipBehavior: Clip.none,
                shrinkWrap: true, // Important to avoid infinite height error
                physics:
                    const NeverScrollableScrollPhysics(), // Prevent internal scrolling
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const GuideCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

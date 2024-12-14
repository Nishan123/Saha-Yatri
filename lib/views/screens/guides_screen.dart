import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:saha_yatri/views/widgets/guide_card.dart';
import 'package:saha_yatri/views/widgets/search_bar_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GuidesScreen extends StatefulWidget {
  const GuidesScreen({super.key});

  @override
  State<GuidesScreen> createState() => _GuidesScreenState();
}

class _GuidesScreenState extends State<GuidesScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose(); // Dispose of the controller to free memory
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saha-Yatri"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Search bar
              SearchBarField(
                hintText: "Search your Saha-Yatri / destination",
                controller: searchController,
                prefixIcon: const Icon(FeatherIcons.search),
              ),
              // Displaying guides from Firestore
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('user', isEqualTo: 'guide')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No guides available'));
                    }

                    final guides = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: guides.length,
                      itemBuilder: (context, index) {
                        final guideData =
                            guides[index].data() as Map<String, dynamic>;
                        final String name = guideData['username'] ?? 'No Name';
                        final String phone = guideData['phone'] ?? 'No Phone';
                        final String experience =
                            guideData['yearOfExp'] ?? 'No Experience';

                        return GuideCard(
                          name: name,
                          phone: phone,
                          experience: experience,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

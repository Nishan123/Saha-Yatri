import 'package:flutter/material.dart';

class CurrentLocationWidget extends StatelessWidget {
  final Future<String> locationData;
  const CurrentLocationWidget({
    super.key,
    required this.locationData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 220, 220),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_rounded,
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text("You are at "),
          Flexible(
            child: FutureBuilder<String>(
                future: locationData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      "Fetching location...",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}",
                        style: const TextStyle(fontWeight: FontWeight.bold));
                  } else if (snapshot.hasData) {
                    return Text("${snapshot.data}",
                        style: const TextStyle(fontWeight: FontWeight.bold));
                  } else {
                    return const Text("Unable to fetch location",
                        style: TextStyle(fontWeight: FontWeight.bold));
                  }
                }),
          ),
        ],
      ),
    );
  }
}

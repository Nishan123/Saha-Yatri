import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:saha_yatri/views/screens/destination_screen.dart';

class DestinationCard extends StatelessWidget {
  final String destinationName;
  final String destinationAddress;
  final String distance;
  const DestinationCard({
    super.key,
    required this.destinationName,
    required this.destinationAddress,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DestinationScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: mq.height * 0.3,
              width: mq.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 0),
                  ),
                ],
                color: Colors.black12,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              destinationName,
              maxLines: 1,
              softWrap: true,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              destinationAddress,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black38,
              ),
            ),
            Row(
              children: [
                const Icon(
                  FeatherIcons.mapPin,
                  size: 14,
                  color: Colors.black38,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  distance,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:saha_yatri/views/theme/custom_text_style.dart';
import 'package:saha_yatri/views/widgets/custom_button.dart';
import 'package:saha_yatri/views/widgets/map_view.dart';
import 'package:saha_yatri/views/widgets/tag_chips.dart';

class DestinationScreen extends StatelessWidget {
  final String image;
  final String destinationName;
  final String distance;
  final String address;
  final String description;
  final String tags;
  final String latLong;
  const DestinationScreen({
    super.key,
    required this.image,
    required this.destinationName,
    required this.distance,
    required this.description,
    required this.tags,
    required this.latLong,
    required this.address,
  });
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DestinationImage(
                mq: mq,
                image: "assets/tourists.png",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destinationName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      address,
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          FeatherIcons.mapPin,
                          size: 16,
                          color: Colors.black45,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          distance,
                          style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      description,
                    ),
                    const MapBoxView(),
                    CustomButton(
                      backgroundColor: Colors.black,
                      onPressed: () {},
                      text: "Get Directions",
                      textColor: Colors.white,
                      icon: FeatherIcons.compass,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TagChips(tags: ["One", "Two", "Three", "Four"]),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Recommended Guides 🌟",
                      style: CustomTextStyle.heading2,
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          RecommandedGuides(image: "assets/aakash.jpg",),
                          RecommandedGuides(image: "assets/rohan.jpg",),
                          RecommandedGuides(image: "assets/dad.jpg",),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecommandedGuides extends StatelessWidget {
  final String image;
  const RecommandedGuides({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:AssetImage(image) ,
          ),
          const SizedBox(
            height: 2,
          ),
          const Text("Guide's name")
        ],
      ),
    );
  }
}

class DestinationImage extends StatelessWidget {
  final String image;
  const DestinationImage({
    super.key,
    required this.mq,
    required this.image,
  });

  final Size mq;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: mq.height * 0.35,
        width: mq.width,
        color: const Color.fromARGB(255, 111, 104, 101),
        child: ClipRRect(
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ));
  }
}

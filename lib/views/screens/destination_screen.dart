import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class DestinationScreen extends StatelessWidget {
  const DestinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DestinationImage(mq: mq),
          const Text(
            "Place Name",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Text(
            "Place address",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 16,
            ),
          ),
          const Row(
            children: [
              Icon(
                FeatherIcons.mapPin,
                size: 16,
                color: Colors.black45,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "Distance",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "kjbas ads gs dfg sdf ghdsf gq rwaHGRAEH TEJ E y  je rg wre gwa45ehgw4s5gre g er hgrt hws5 g sfg sr ht gwrsbsdf b sdf bv st bv fddsg sr hs rht erhs dg wer her hw re h",
            maxLines: 8,
            overflow: TextOverflow.ellipsis,
          )
        ],
      )),
    );
  }
}

class DestinationImage extends StatelessWidget {
  const DestinationImage({
    super.key,
    required this.mq,
  });

  final Size mq;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mq.height * 0.35,
      width: mq.width,
      color: const Color.fromARGB(255, 111, 104, 101),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_circle_left,
                  color: Colors.black,
                  size: 45,
                )),
          )
        ],
      ),
    );
  }
}

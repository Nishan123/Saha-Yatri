import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:saha_yatri/views/widgets/tag_chips.dart';

class GuidesProfile extends StatelessWidget {
  const GuidesProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 120,
                  width: 120,
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
               const  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Guide's name"),
                    Text("Available status"),
                    Row(
                      children: [Icon(FeatherIcons.clock), Text("Experience")],
                    ),
                    Text("Pricing")
                  ],
                ),
              ],
            ),
            const CustomDivider(),
            Text(
                "Guides Bio dksbfak dfkasdjf aksd vkjasd fkv sdkv smd vksa dvlka sdvk askd vksd v dskv kdfj vkasj dkwaoergerbalsdv lv alsd fb sht se df as fd asg s dag e thq arh eag sd g ad f as dga rrg sdfg da g adsg sdf hg sd fh sdr"),
            const CustomDivider(),
            Text("Speaks"),
            TagChips(tags: ["Nepali","Hindi","English","koren","Japanese","Jamali"])
          ],
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

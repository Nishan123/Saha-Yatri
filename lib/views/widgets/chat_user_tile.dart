import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ChatUserTile extends StatelessWidget {
  final String text;
  final String lastMessage;
  final void Function()? onTap;

  const ChatUserTile({
    super.key,
    required this.text,
    required this.lastMessage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10,),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          children: [
            const CircleAvatar(
              child: Icon(FeatherIcons.user),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  lastMessage,
                  style: const TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

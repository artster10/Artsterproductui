import 'package:flutter/material.dart';
import 'package:productui/config/colors.dart';
import 'package:productui/screens/message_detail/message_detail_screen.dart';
import 'package:productui/screens/widgets/profile_image.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.name, required this.message});
  final String name;
  final String message;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => MessageDetailScreen()),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: kWhite.withOpacity(0.60),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileImage(
              radius: 35.0,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: kBlack),
                  ),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

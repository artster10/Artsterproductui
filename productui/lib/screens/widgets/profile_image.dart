import 'package:flutter/material.dart';
import 'package:productui/config/colors.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.radius,
  });
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1.0, color: kBlack),
      ),
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/images/profile_image.jpg'),
        radius: radius,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:keviiapp/colorScheme.dart';

class Avatar extends StatelessWidget {
  final String avatarURL;
  final Function onTap;

  const Avatar({this.avatarURL, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: avatarURL == null
            ? CircleAvatar(
          radius: 80,
              backgroundColor: KELightRed,
              child: CircleAvatar(
          radius: 70,
          child: Icon(Icons.photo_camera),
        ),
            )
            : CircleAvatar(
          radius: 80,
              backgroundColor: KELightRed,
              child: CircleAvatar(
          radius: 70,
          backgroundImage: Image.network(avatarURL).image,
        ),
            ),
      ),
    );
  }
}
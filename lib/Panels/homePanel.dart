import 'package:flutter/material.dart';

import '../colorScheme.dart';

class homePanel extends StatelessWidget {
  String imrURL, headline, subheading, news;
  Widget nextPage;

  homePanel(
      this.imrURL, this.headline, this.subheading, this.news, this.nextPage);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 3),
          height: 200,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => nextPage));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(this.imrURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Container(
          color: bgColor,
          child: Text(headline,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, fontFamily: 'Montserrat', color: KERed),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 10),
          color: bgColor,
          child: Text(subheading,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, fontFamily: 'Montserrat',),
            overflow: TextOverflow.ellipsis,
          ),
        ),

      ],
    );
  }
}

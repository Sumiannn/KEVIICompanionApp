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
    return Card(
        margin: EdgeInsets.only(bottom: 22.0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 0.0,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => nextPage));
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(this.imrURL),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: bgColor
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            headline,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: KERed,

                              fontSize: 20.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(subheading,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )

          ],
        )
        /*child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => nextPage));
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(this.imrURL),
              fit: BoxFit.cover,
              scale: 2.0,
            )),
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: KELightYellow
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                headline,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: KERed,

                                  fontSize: 20.0,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(subheading,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ])),
          ),
        )*/);
  }
}

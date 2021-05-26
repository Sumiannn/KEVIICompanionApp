import 'package:flutter/material.dart';
import 'package:keviiapp/bookingPage.dart';
import 'bookingPage.dart';

class homePanel extends StatelessWidget {
  String imrURL, eventName, brief;
  StatelessWidget nextPage;

  homePanel(String imgURL, String eventName, String brief, StatelessWidget nextPage) {
    this.imrURL = imgURL;
    this.eventName = eventName;
    this.brief = brief;
    this.nextPage = nextPage;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(right: 22.0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextPage)
            );
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(this.imrURL),
                  fit: BoxFit.cover,
                  scale: 2.0,
                )
            ),
            width: 310.0,
            child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventName,
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 22.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 3.0,),
                      Text(
                          brief,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ))
                    ]
                )
            ),
          ),
        )
    );
  }
}
  /*
  Widget homePanel(String imgURL, String eventName, String brief){
    return Card(
        margin: EdgeInsets.only(right: 22.0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation:5.0,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => bookingPage())
            );
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imgURL),
                  fit: BoxFit.cover,
                  scale: 2.0,
                )
            ),
            width: 310.0,
            child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventName,
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 22.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 3.0,),
                      Text(
                          brief,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ))
                    ]
                )
            ),
          ),
        )
    );
  }
}

   */



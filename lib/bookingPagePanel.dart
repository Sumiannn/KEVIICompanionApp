import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/bookingPage.dart';

class bookingPagePanel extends StatelessWidget {
  final Color boxColor = Colors.amberAccent;
  final Color textColor = Colors.white;
  String venue;
  Timestamp timeStamp;
  //might want to includew the stateless wideget nextPage
  // StatelessWidget nextPage (put in constructor also)

  bookingPagePanel(String venue) {
    this.venue = venue;
    //this.timeStamp = timestamp;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(right: 10.0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => bookingPage())
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: boxColor,
            ),
            width: 310.0,
            child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        venue,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 22.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 3.0,),
                      Text(
                          venue,
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

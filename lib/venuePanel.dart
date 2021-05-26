import 'package:flutter/material.dart';
import 'package:keviiapp/bookingPage.dart';
import 'bookingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class venuePanel extends StatelessWidget {

  final CollectionReference _bookings = FirebaseFirestore.instance.collection("Facilities");
  String imrURL, venue, dateAndTime;

  venuePanel(String imgURL, String venue, String dateAndTime) {
    this.imrURL = imgURL;
    this.venue = venue;
    this.dateAndTime = dateAndTime;
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
                MaterialPageRoute(builder: (context) => bookingPage())
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
                        venue,
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 22.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 3.0,),
                      Text(
                          dateAndTime,
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
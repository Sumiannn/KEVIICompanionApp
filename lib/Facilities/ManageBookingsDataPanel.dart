import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Facilities/AddBooking.dart';
import 'package:keviiapp/Facilities/EditBookings.dart';
import 'package:keviiapp/Facilities/FacilitiesBookingPage.dart';
import 'package:keviiapp/colorScheme.dart';

import '../Facilities/BookingDataPage.dart';

class ManageBookingsDataPanel extends StatelessWidget {
  final Color boxColor = Colors.amberAccent;
  final Color textColor = Colors.white;
  String venue, date, StartTime, EndTime, numOfPax, ccaBlock, referenceCode;
  Timestamp StartTimeStamp;
  DateTime newDate;
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  //might want to includew the stateless wideget nextPage
  // StatelessWidget nextPage (put in constructor also)

  ManageBookingsDataPanel(this.venue, this.date, this.StartTime, this.EndTime,
      this.StartTimeStamp, this.numOfPax, this.ccaBlock, this.referenceCode) {
    newDate = StartTimeStamp.toDate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      InkWell(
        key: Key('Panel'),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditBookings(referenceCode)
              ));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: MediaQuery.of(context).size.height * 0.10,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: KELightYellow,
          ),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        newDate.day.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 25.0,
                            color: KERed),
                      ),
                      Text(
                        months[newDate.month - 1],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: KERed),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        venue,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20 ,
                            color: KERed),
                      ),
                      Text(StartTime + ' to ' + EndTime,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery.of(context).size.height*0.016,
                              color: KERed))
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
      Positioned(
        right: 15,
        top: 8,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                numOfPax,
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 23, color: KERed),
              ),
              Icon(
                Icons.people_alt_rounded,
                size: 30,
                color: KERed,
              )
            ],
          ),
        ),
      )
    ]);
  }
}

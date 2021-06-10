import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Screens/AddBooking.dart';
import 'package:keviiapp/Screens/FacilitiesBookingPage.dart';
import 'package:keviiapp/colorScheme.dart';

import '../Screens/BookingDataPage.dart';

class bookingPagePanel extends StatelessWidget {
  final Color boxColor = Colors.amberAccent;
  final Color textColor = Colors.white;
  int MPC = 0, CommHall = 1, DanceStudio = 2, index;
  List<String> imgURL = [
    'https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/152795070_1406944926321311_4322317643113755872_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=0debeb&_nc_ohc=PW5xTNoXRKgAX8nSUGO&tn=g9Z8h1jx25xvmq03&_nc_ht=scontent.fsin7-1.fna&oh=cd05c91ba2e00824a46391c7c018db80&oe=60D74A00',
    'https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/118488392_1262987244050414_1013666737303175562_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=0debeb&_nc_ohc=eaRiI1lBy_YAX9IZa9e&_nc_ht=scontent.fsin7-1.fna&oh=e7a617679863de87848c33cc665dbc37&oe=60D6BD87',
    'https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/56679359_860544750961334_6665091079278166016_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=cdbe9c&_nc_ohc=wHP-odKdEUMAX8vQpV-&_nc_ht=scontent.fsin7-1.fna&oh=a82c5d35519971b6391702f8fc413c9b&oe=60D79764'
  ];
  String venue, date, StartTime, EndTime, numOfPax, ccaBlock;
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

  bookingPagePanel(this.venue, this.date, this.StartTime, this.EndTime,
      this.StartTimeStamp, this.numOfPax, this.ccaBlock) {
    if (this.venue == 'MPC') {
      index = MPC;
    } else if (this.venue == 'Comm Hall') {
      index = CommHall;
    } else if (this.venue == 'Dance Studio') {
      index = DanceStudio;
    }
    newDate = StartTimeStamp.toDate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BookingDataPage(venue, StartTime, EndTime, date, numOfPax, ccaBlock),
              ));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: MediaQuery.of(context).size.height * 0.09,
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
                            fontSize: 25,
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
                              fontSize: 13,
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

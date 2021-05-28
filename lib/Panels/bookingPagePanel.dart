import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/AddBooking.dart';
import 'package:keviiapp/Screens/FacilitiesBookingPage.dart';

class bookingPagePanel extends StatelessWidget {
  final Color boxColor = Colors.amberAccent;
  final Color textColor = Colors.white;
  int MPC = 0,
      CommHall = 1,
      DanceStudio = 2,
      index;
  List<String> imgURL = [
    'https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/152795070_1406944926321311_4322317643113755872_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=0debeb&_nc_ohc=PW5xTNoXRKgAX8nSUGO&tn=g9Z8h1jx25xvmq03&_nc_ht=scontent.fsin7-1.fna&oh=cd05c91ba2e00824a46391c7c018db80&oe=60D74A00',
    'https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/118488392_1262987244050414_1013666737303175562_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=0debeb&_nc_ohc=eaRiI1lBy_YAX9IZa9e&_nc_ht=scontent.fsin7-1.fna&oh=e7a617679863de87848c33cc665dbc37&oe=60D6BD87',
    'https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/56679359_860544750961334_6665091079278166016_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=cdbe9c&_nc_ohc=wHP-odKdEUMAX8vQpV-&_nc_ht=scontent.fsin7-1.fna&oh=a82c5d35519971b6391702f8fc413c9b&oe=60D79764'
  ];
  String venue, date, time;
  Timestamp timeStamp;

  //might want to includew the stateless wideget nextPage
  // StatelessWidget nextPage (put in constructor also)

  bookingPagePanel(this.venue, this.date, this.time) {
    if (this.venue == 'MPC') {
      index = MPC;
    } else if (this.venue == 'Comm Hall') {
      index = CommHall;
    } else if (this.venue == 'Dance Studio') {
      index = DanceStudio;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF820312),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1.0),
      ),
      elevation: 0.0,
      child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddBooking(),));
          },
          child:
          Stack(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(10.0),
                  child: Image(image: NetworkImage(imgURL[index]),)),
              Positioned(
                  top: 15,
                  right: 15,
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: Colors.amber,
                  )
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Text(
                    venue,
                    style: TextStyle(
                        color: boxColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0,
                        fontFamily: 'Montserrat'
                    ),
                  ),
                ],),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                            color: boxColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                      SizedBox(width: 200.0,),
                      Text(
                        time,
                        style: TextStyle(
                            color: boxColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),

      ),
    );
  }
}

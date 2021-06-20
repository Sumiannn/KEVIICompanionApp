import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../colorScheme.dart';

class BookingDataPage extends StatefulWidget {
  String venue, startTime, endTime, date, numberOfPax, ccaBlock, referenceCode;

  BookingDataPage(this.venue, this.startTime, this.endTime, this.date,
      this.numberOfPax, this.ccaBlock, this.referenceCode);

  _BookingDataPageState createState() => _BookingDataPageState(
      venue, startTime, endTime, date, numberOfPax, ccaBlock, referenceCode);
}

class _BookingDataPageState extends State<BookingDataPage> {
  String userID,
      usedBy,
      venue,
      startTime,
      endTime,
      date,
      numberOfPax,
      ccaBlock,
      referenceCode;
  Timestamp startDateTime, endDateTime;
  int MPC = 0,
      CommHall = 1,
      SquashCourt = 2,
      TennisCourt = 3,
      DanceStudio = 4,
      HeritageRoom = 5,
      DiningHall = 6,
      index;
  List<String> imgURL = [
    'assets/BookingVenues/MPC.jpg',
    'assets/BookingVenues/CommHall.jpg',
    'assets/BookingVenues/SquashCourt.jpg',
    'assets/BookingVenues/TennisCourt.jpg',
    'assets/BookingVenues/DanceStudio.jpg',
    'assets/BookingVenues/HeritageRoom.jpg',
    'assets/BookingVenues/DiningHall.jpg',
  ];

  _BookingDataPageState(this.venue, this.startTime, this.endTime, this.date,
      this.numberOfPax, this.ccaBlock, this.referenceCode) {
    if (this.venue == 'MPC') {
      index = MPC;
    } else if (this.venue == 'Comm Hall') {
      index = CommHall;
    } else if (this.venue == 'Squash Courts') {
      index = SquashCourt;
    } else if (this.venue == 'Tennis Courts') {
      index = TennisCourt;
    } else if (this.venue == 'Dance Studio') {
      index = DanceStudio;
    } else if (this.venue == 'Heritage Room') {
      index = HeritageRoom;
    } else if (this.venue == 'Dining Hall') {
      index = DiningHall;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      imgURL[index],
                      alignment: Alignment.topLeft,
                      fit: BoxFit.fitWidth,
                    )),
                Positioned(
                  top: 15,
                  left: 15,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                Positioned(
                  top: 230,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: bgColor,
                    ),
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                child: Icon(
                                  Icons.library_books_outlined,
                                  color: KEYellow,
                                  size: 50.0,
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Reference Code:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  referenceCode,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Column(
                            children: [
                              infoWidget('Venue', venue,
                                  Icon(Icons.location_on_rounded)),
                              infoWidget("Date", date, Icon(Icons.date_range)),
                              infoWidget(
                                  "Duration",
                                  startTime + ' to ' + endTime,
                                  Icon(Icons.access_time_rounded)),
                              infoWidget("Booked By", ccaBlock,
                                  Icon(Icons.group_rounded)),
                              infoWidget("Number of People", numberOfPax,
                                  Icon(Icons.emoji_people_rounded)),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Container infoWidget(String infoTitle, String info, Icon image) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: KELightYellow),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: 40.0,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: KEYellow),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image,
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  infoTitle,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
                Text(
                  info,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class pathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = KELightRed;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.40,
        size.width * 0.58, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.72, size.height * 0.8,
        size.width * 0.92, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.98, size.height * 0.8, size.width, size.height * 0.82);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

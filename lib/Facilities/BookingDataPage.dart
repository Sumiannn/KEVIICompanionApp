import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../colorScheme.dart';

class BookingDataPage extends StatefulWidget {
  String venue, startTime, endTime, date, numberOfPax, ccaBlock, referenceCode;

  BookingDataPage(this.venue, this.startTime, this.endTime, this.date, this.numberOfPax, this.ccaBlock, this.referenceCode);

  _BookingDataPageState createState() =>
      _BookingDataPageState(venue, startTime, endTime, date, numberOfPax, ccaBlock, referenceCode);
}

class _BookingDataPageState extends State<BookingDataPage> {
  String userID, usedBy, venue, startTime, endTime, date, numberOfPax, ccaBlock, referenceCode;
  Timestamp startDateTime, endDateTime;
  int MPC = 0, CommHall = 1, SquashCourt = 2, TennisCourt = 3, DanceStudio = 4, HeritageRoom = 5, DiningHall = 6, index;
  List<String> imgURL = [
    'https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/154692928_1408458799503257_2644835914742009710_n.jpg?_nc_cat=105&ccb=1-3&_nc_sid=0debeb&_nc_ohc=dwpuIyP4-KMAX_-3HN1&_nc_ht=scontent.fsin7-1.fna&oh=e457900a67f5dec1a6dbabf315ec13ef&oe=60C7C5CD',
    'https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/154692928_1408458799503257_2644835914742009710_n.jpg?_nc_cat=105&ccb=1-3&_nc_sid=0debeb&_nc_ohc=dwpuIyP4-KMAX_-3HN1&_nc_ht=scontent.fsin7-1.fna&oh=e457900a67f5dec1a6dbabf315ec13ef&oe=60C7C5CD',
    'https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/69104064_953490665000075_6525877380894949376_n.jpg?_nc_cat=101&ccb=1-3&_nc_sid=cdbe9c&_nc_aid=0&_nc_ohc=NIAo8HD-qu8AX-YoEgq&_nc_ht=scontent.fsin7-1.fna&oh=0cb3e8ba7efd95b8c9a896a98cb3ec63&oe=60C794D1',
    'https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/161011285_1418566218492515_3522713555380780871_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=0debeb&_nc_ohc=Zu_7Lhz1T4sAX-_S2vW&_nc_ht=scontent.fsin7-1.fna&oh=8850915a82d2bbae95527e419cd6d495&oe=60C6FF14',
    'https://cdn2.hubspot.net/hubfs/2620837/Imported_Blog_Media/Urband-dance-Studio-1.jpg',
    'https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/166675118_1428634354152368_3226097963581441149_n.jpg?_nc_cat=104&ccb=1-3&_nc_sid=0debeb&_nc_ohc=ka-ohoeo1rEAX-6jv2_&_nc_ht=scontent.fsin7-1.fna&oh=0525fdd665c69be453d80a456b00056d&oe=60C8CA8C',
    'https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/118727987_1269657280050077_6685992467446830307_n.jpg?_nc_cat=109&ccb=1-3&_nc_sid=0debeb&_nc_ohc=Yzi5DBi8Y9QAX8sHIos&tn=g9Z8h1jx25xvmq03&_nc_ht=scontent.fsin7-1.fna&oh=c57c8d72201f8cbbc556cc74123556ad&oe=60C8A16B',
  ];

  _BookingDataPageState(this.venue, this.startTime, this.endTime, this.date, this.numberOfPax, this.ccaBlock, this.referenceCode) {
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
                  child: Image.network(
                    imgURL[index],
                    alignment: Alignment.topLeft,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
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
                              infoWidget(
                                  "Date", date, Icon(Icons.date_range)),
                              infoWidget("Duration", startTime + ' to ' + endTime,
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

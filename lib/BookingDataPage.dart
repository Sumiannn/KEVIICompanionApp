
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'colorScheme.dart';

class BookingDataPage extends StatefulWidget {
  String venue, startTime, endTime, date;
  BookingDataPage(this.venue, this.startTime, this.endTime, this.date);
  _BookingDataPageState createState() => _BookingDataPageState(venue, startTime, endTime, date);
}

class _BookingDataPageState extends State<BookingDataPage> {

  int numberOfPax;
  String userID, usedBy, venue, startTime, endTime, date;
  Timestamp startDateTime, endDateTime;

  _BookingDataPageState(this.venue, this.startTime, this.endTime, this.date);
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: bgColor,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [KEYellow, KELightRed],
                        begin: Alignment(0, -1.15),
                        end: Alignment(0,0.1),
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                          child: Container(

                            child: Image.network('https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/40773051_735925123423298_3456762337506099200_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=e3f864&_nc_ohc=4zc4MvIswKwAX8XkQoF&_nc_ht=scontent.fsin7-1.fna&oh=469dfbbec187778c1d6cd15cf1949932&oe=60DAF301'),
                          )
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
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
                                        child: Icon(Icons.library_books_outlined, color: KERed,)
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Reference Code:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                          ),),
                                        Text('To be added',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 5.0,),
                                infoWidget('Venue', 'venue', Icon(Icons.location_on_rounded)),
                                infoWidget("Start Time", 'startTime', Icon(Icons.access_time_rounded))
                              ],
                            )
                        ),
                      )
                    ],
                  )
              )
            ],
          )
        ],
      ),
    );
  }
  Container infoWidget(String infoTitle, String info, Icon image) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: KELightYellow
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: KEYellow
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image,
                ],
              ),
            ),
            SizedBox(width: 20.0,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(infoTitle, style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                    fontSize: 25
                ),),
                Text(info, style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                ),)
              ],
            )
          ],
        ),

      ),

    );
  }
}
/*
class BookingDataPage extends StatelessWidget {
  int numberOfPax;
  String userID, usedBy, venue, startTime, endTime, date;
  Timestamp startDateTime, endDateTime;

  BookingDataPage(String venue, String startTime, String endTime, String date){
    this.venue = venue;
    this.startTime = startTime;
    this.endTime = endTime;
    this.date = date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: bgColor,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [KEYellow, KELightRed],
                    begin: Alignment(0, -1.15),
                    end: Alignment(0,0.1),
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: Container(

                        child: Image.network('https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/40773051_735925123423298_3456762337506099200_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=e3f864&_nc_ohc=4zc4MvIswKwAX8XkQoF&_nc_ht=scontent.fsin7-1.fna&oh=469dfbbec187778c1d6cd15cf1949932&oe=60DAF301'),
                      )
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
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
                                  child: Icon(Icons.library_books_outlined, color: KERed,)
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Reference Code:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                    ),),
                                    Text('To be added',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ),
                    )
                  ],
                )
              )
            ],
          )
        ],
      ),
    );
  }
  Container infoWidget(String infoTitle, String info, Icon image) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: KELightYellow
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: KEYellow
                ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_rounded, color: bgColor, size: 20,),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(infoTitle, style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 20
                ),),
                Text(info, style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),)
              ],
            )
          ],
        ),
        
      ),

    );
  }

}

 */
class pathPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = KELightRed;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width*0.35, size.height*0.40, size.width*0.58, size.height*0.6);
    path.quadraticBezierTo(size.width*0.72, size.height*0.8, size.width*0.92, size.height*0.8);
    path.quadraticBezierTo(size.width*0.98, size.height*0.8, size.width, size.height*0.82);
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


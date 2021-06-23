import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Facilities/FacilitiesBookingPage.dart';
import 'package:keviiapp/HomePage/home.dart';
import 'package:keviiapp/SignInSignUp/email_login.dart';

import '../colorScheme.dart';

class BookingConfirmationPage extends StatefulWidget {
  String venue, date, start, end, numPax, cca;

  BookingConfirmationPage(
      this.venue,
      this.date,
      this.start,
      this.end,
      this.numPax,
      this.cca
      );
  @override
  _BookingConfirmationPageState createState() => _BookingConfirmationPageState(
    this.venue,
    this.date,
    this.start,
    this.end,
    this.numPax,
    this.cca
  );
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  String venue, date, start, end, numPax, cca;

  _BookingConfirmationPageState(
      this.venue,
      this.date,
      this.start,
      this.end,
      this.numPax,
      this.cca);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: pathPainter(),
          ),
        ),
          Positioned(
            top: 25,
            left: 15,
            child: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: KERed, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 25,
            right: 55,
            child: IconButton(
              icon: Icon(Icons.home_rounded, color: KERed, size: 30),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                        (Route<dynamic> route) => false);
              },
            ),
          ),
          Positioned(
            top: 25,
            right: 15,
            child: IconButton(
              icon: Icon(
                Icons.exit_to_app_rounded,
                color: KERed,
                size: 30,
              ),
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => EmailLogIn()),
                          (Route<dynamic> route) => false);
                });
              },
            ),
          ),
          Positioned(
            top: 80,
            left: 135,
            child: Center(
              child: Icon(Icons.assignment_turned_in_rounded, size: 130, color: KERed,),
            ),
          ),
          Positioned(
            top: 220,
            child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.only(right: 12),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Booking Added Successfully! \n Details are as follows.',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: KERed),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        Positioned(
          top: 300,
          left: 25,
          right: 25,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              infoPanel(Icons.location_on_rounded, 'Venue', venue),
              infoPanel(Icons.date_range_rounded, 'Date', date),
              infoPanel(Icons.watch_later_outlined, 'Start Time', start),
              infoPanel(Icons.watch_later_outlined, 'End Time', end),
              infoPanel(Icons.sports_tennis_rounded, 'Booked by', cca),
              infoPanel(Icons.group, 'Number of Pax', numPax),
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => FacilitiesBookingPage()));
                  },
                child: Center(
                    child: Text(
                      'Go to bookings',
                      style: TextStyle(
                          color: KERed,
                          fontSize: 19,
                          fontWeight: FontWeight.w700),
                    )),)
            ],
          )
        ),
        ],

      ),

    );
  }
  Widget infoPanel(IconData iconImage, String label, String labelText) {
    return Container(
      margin: EdgeInsets.only(top: 15,),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.13,
      decoration: BoxDecoration(
        color: KELightRed,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width * 0.1,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: KERed,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(iconImage, color: bgColor, size: 25,),
          ),
          SizedBox(width:10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.start,),
              Text(labelText,style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13), textAlign: TextAlign.start,)
            ],
          )
        ],
      ),
    );
  }
}



Widget buildTextField(String labelText, String placeHolder) {
  return Padding(
    padding: EdgeInsets.only(bottom: 14.5),
    child: TextField(
      enabled: false,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(bottom: 5),
        labelText: labelText,
        labelStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w700, color: KEYellow),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeHolder,
        hintStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: KEYellow),
      ),
    ),
  );
}

class pathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = KELightYellow;

    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.03,
        size.width * 0.42, size.height * 0.17);
    path.quadraticBezierTo(
        size.width * 0.35, size.height * 0.32, 0, size.height * 0.29);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

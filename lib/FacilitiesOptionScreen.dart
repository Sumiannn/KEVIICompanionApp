import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Screens/AddBooking.dart';
import 'package:keviiapp/Screens/FacilitiesBookingPage.dart';
import 'package:keviiapp/colorScheme.dart';

import 'Screens/BookingDataPage.dart';
import 'Screens/email_login.dart';
import 'Screens/home.dart';

class FacilitiesOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Container(
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
            top: 75,
            left: 25,
            child: Text(
              "Facilities",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: KERed),
            ),
          ),
          Positioned(
            top: 125,
            left: 25,
            right: 25,
            child: Container(
              padding: EdgeInsets.only(right: 12),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "You can check out who's using the facilities, manage your exisiting bookings or add a booking here!",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: KERed),
              ),
            ),
          ),
          Positioned(
            top: 230,
            left: 20,
            right: 20,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: KELightRed,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/ManageBookingsImage.png',
                      fit: BoxFit.fill,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Manage My Bookings",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: KERed),
                          ),
                          Text(
                            "Change or update my bookings' timings, venue, or other details",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: KERed),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {}, //TODO
            ),
          ),
          Positioned(
              top: 385,
              left: 20,
              right: 20,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: KELightRed,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/image/CurrentBookingsImage.png',
                        fit: BoxFit.fill,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Check current Bookings",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: KERed),
                            ),
                            Text(
                              "Obtain details about current bookings",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: KERed),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FacilitiesBookingPage()));
                }, //TODO
              )),
          Positioned(
              top: 540,
              left: 20,
              right: 20,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: KELightRed,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/image/AddBookingImage.png',
                        fit: BoxFit.fill,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add a Booking",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: KERed),
                            ),
                            Text(
                              "Make bookings for facilities",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: KERed),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddBooking()));
                }, //TODO
              ))
        ],
      ),
    );
  }
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

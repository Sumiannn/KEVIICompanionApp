import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keviiapp/Screens/FacilitiesBookingPage.dart';
import 'package:keviiapp/signup.dart';

import '../colorScheme.dart';
import 'email_login.dart';
import 'home.dart';

class AddBooking extends StatefulWidget {
  @override
  _AddBookingState createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  String title = 'Add a Booking', venueChoose;

  DateTime dateChosen, start;
  TimeOfDay startTime, endTime;
  static final DateTime isNow = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
  ).add(const Duration(hours: 8));

  _AddBookingState();

  @override
  void initState() {
    super.initState();
  }

  Future<Null> selectDatePicker(BuildContext context) async {
    final DateTime datePicked = await showDatePicker(
        context: context,
        initialDate: isNow,
        firstDate: isNow,
        lastDate: isNow.add(const Duration(days: 365)));
    if (datePicked != null) {
      setState(() {
        dateChosen = datePicked;
      });
    }
  }

  Future<Null> selectStartTimePicker(BuildContext context) async {
    final TimeOfDay timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(isNow),
    );
    if (timePicked != null) {
      setState(() {
        startTime = timePicked;
      });
    }
  }

  Future<Null> selectEndTimePicker(BuildContext context) async {
    final TimeOfDay timePicked = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(isNow));
    if (timePicked != null) {
      setState(() {
        endTime = timePicked;
      });
    }
  }

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
              "Book a facility",
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
                "Choose the time, date and facility for the booking along with some other additional details to complete the booking!",
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
            child: Form(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: KELightRed,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/location.png',
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Available Facilities')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text('Loading, please wait');
                                }
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: DropdownButton(
                                    hint: Text(
                                      'Select a Venue',
                                      style: TextStyle(
                                          color: KERed,
                                          fontSize: 19.0,
                                          fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700),
                                    ),
                                    dropdownColor: KELightRed,
                                    icon: Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: KERed,
                                    ),
                                    iconSize: 25.0,
                                    underline: SizedBox(),
                                    isExpanded: true,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: KERed,
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w700
                                    ),
                                    value: venueChoose,
                                    onChanged: (newValue) {
                                      setState(() {
                                        venueChoose = newValue;
                                      });
                                    },
                                    items: snapshot.data.docs.map<DropdownMenuItem<String>>(
                                            (DocumentSnapshot document) {
                                          return new DropdownMenuItem<String>(
                                            value: document['Value'],
                                            child: Text(
                                              document['Value'],
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 19.0,
                                                color: KERed,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                );
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 320,
            left: 20,
            right: 20,
            child: InkWell(
              child:
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: KELightRed,
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/image/calendar.png'),
                      SizedBox(width: 10),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: dateChosen != null ?Text(
                              dateChosen.day.toString() +
                              ' - ' +
                              dateChosen.month.toString() +
                              ' - ' +
                              dateChosen.year.toString(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19, color: KERed),) :
                          Text("Select a Date", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19, color: KERed),)),
                      SizedBox(width: 45.0),

                    ],
                  ),
                ),
              onTap: () {
                selectDatePicker(context);
              },
            ),
          ),
          Positioned(
            top: 410,
            left: 20,
            right: 20,
            child: InkWell(
              child:
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: KELightRed,
                ),
                child: Row(
                  children: [
                    Image.asset('assets/image/calendar.png'),
                    SizedBox(width: 10),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: dateChosen != null ?Text(
                          dateChosen.day.toString() +
                              ' - ' +
                              dateChosen.month.toString() +
                              ' - ' +
                              dateChosen.year.toString(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19, color: KERed),) :
                        Text("Select a Date", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19, color: KERed),)),
                    SizedBox(width: 45.0),

                  ],
                ),
              ),
              onTap: () {
                selectDatePicker(context);
              },
            ),
          ),

          Positioned(
            top: 700,
            left: 20,
            right: 20,
                child: ElevatedButton(
                  onPressed: () {
                    if(venueChoose != null) {
                      addBooking();
                    }
                    return null;
                  },
                  child: venueChoose == null ? Container(
                    child: Text("Choose a valid Venue"),
                  ): Text('Add Booking'),
                ),
              ),
            ],
          )
      /*
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: dateChosen == null
                  ? Text('Select a Date: ')
                  : Text('Selected Date: ' +
                      dateChosen.day.toString() +
                      '-' +
                      dateChosen.month.toString() +
                      '-' +
                      dateChosen.year.toString()),
              onPressed: () {
                selectDatePicker(context);
              },
            ),
            ElevatedButton(
              child: startTime == null
                  ? Text('Start Time: ')
                  : Text('Start Time: ' + startTime.format(context)),
              onPressed: () {
                selectStartTimePicker(context);
              },
            ),
            ElevatedButton(
              child: endTime == null
                  ? Text('End Time: ')
                  : Text('End Time: ' + endTime.format(context)),
              onPressed: () {
                selectEndTimePicker(context);
              },
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Available Facilities')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Loading, please wait');
                  }
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownButton(
                      hint: Text(
                        'Choose Venue',
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 22.0,
                            fontFamily: 'Montserrat'),
                      ),
                      dropdownColor: Colors.white,
                      icon: Icon(
                        Icons.arrow_drop_down_circle_sharp,
                        color: Colors.amber,
                      ),
                      iconSize: 15.0,
                      underline: SizedBox(),
                      isExpanded: false,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.amber,
                        fontSize: 22.0,
                      ),
                      value: venueChoose,
                      onChanged: (newValue) {
                        setState(() {
                          venueChoose = newValue;
                        });
                      },
                      items: snapshot.data.docs.map<DropdownMenuItem<String>>(
                          (DocumentSnapshot document) {
                        return new DropdownMenuItem<String>(
                          value: document['Value'],
                          child: Text(
                            document['Value'],
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 22.0,
                              color: Colors.amber,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
            SizedBox(height: 5.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  addBooking();
                },
                child: Text('Add Booking'),
              ),
            )
          ],
        ),
      ),

       */
    );
  }

  void addBooking() {
    Stream<QuerySnapshot> AllBookings =
        FirebaseFirestore.instance.collection('Facilities').snapshots();

    DateTime chosenStart = DateTime(dateChosen.year, dateChosen.month,
        dateChosen.day, startTime.hour, startTime.minute);
    DateTime chosenEnd = DateTime(dateChosen.year, dateChosen.month,
        dateChosen.day, endTime.hour, endTime.minute);
    FirebaseFirestore.instance.collection('Facilities').add({
      'Date': dateChosen.day.toString() +
          '-' +
          dateChosen.month.toString() +
          '-' +
          dateChosen.year.toString(),
      'Start time':
          TimeOfDay(hour: chosenStart.hour, minute: chosenStart.minute)
              .format(context),
      'End time': TimeOfDay(hour: chosenEnd.hour, minute: chosenEnd.minute)
          .format(context),
      'Venue': venueChoose,
      'Start Time (Timestamp)': chosenStart.subtract(const Duration(hours: 8)),
      'End Time (Timestamp)': chosenEnd.subtract(const Duration(hours: 8)),
    });
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => FacilitiesBookingPage()));
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

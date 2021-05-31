import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keviiapp/Screens/FacilitiesBookingPage.dart';
import 'package:keviiapp/signup.dart';

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
      backgroundColor: Color(0xFF820312),
      appBar: AppBar(
        backgroundColor: Color(0xFF820312),
        elevation: 0.0,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.w600,
            fontSize: 22.0,
            fontFamily: 'Montserrat',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.amber,
            ),
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                    (Route<dynamic> route) => false);
              });
            },
          )
        ],
      ),
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
    );
  }

  void addBooking() {
    Stream<QuerySnapshot> AllBookings =
        FirebaseFirestore.instance.collection('Facilities').snapshots();

    DateTime chosenStart = DateTime(dateChosen.year, dateChosen.month,
        dateChosen.day, startTime.hour, startTime.minute);
    DateTime chosenEnd = DateTime(dateChosen.year, dateChosen.month,
        dateChosen.day, endTime.hour, endTime.minute);
    /*
    AllBookings.forEach((doc) {
      if (doc== venueChoose)
    });

     */
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

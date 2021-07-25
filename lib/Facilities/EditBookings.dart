import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Facilities/ManageBookingsPage.dart';
import 'package:keviiapp/HomePage/home.dart';
import 'package:keviiapp/SignInSignUp/email_login.dart';

import '../colorScheme.dart';
import 'BookingConfirmationPage.dart';

class EditBookings extends StatefulWidget {
  String referenceCode;

  EditBookings(this.referenceCode);

  @override
  _EditBookingsState createState() => _EditBookingsState(referenceCode);
}

class _EditBookingsState extends State<EditBookings> {
  String referenceCode, venueChoose, ccaFieldText, numPaxField;
  User user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController ccaField = new TextEditingController(),
      numOfPax = new TextEditingController();
  DateTime dateChosen, start;
  TimeOfDay startTime, endTime;

  _EditBookingsState(this.referenceCode);

  DateTime isNow() {
    return DateTime(
      DateTime
          .now()
          .year,
      DateTime
          .now()
          .month,
      DateTime
          .now()
          .day,
      DateTime
          .now()
          .hour,
      DateTime
          .now()
          .minute,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<Null> selectDatePicker(BuildContext context) async {
    DateTime now = isNow();
    final DateTime datePicked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: now.add(const Duration(days: 365)));
    if (datePicked != null) {
      setState(() {
        dateChosen = datePicked;
      });
    }
  }

  Future<Null> selectStartTimePicker(BuildContext context) async {
    DateTime now = isNow();
    final TimeOfDay timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );
    if (timePicked != null) {
      setState(() {
        startTime = timePicked;
      });
    }
  }

  Future<Null> selectEndTimePicker(BuildContext context) async {
    DateTime now = isNow();
    final TimeOfDay timePicked = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(now));
    if (timePicked != null) {
      setState(() {
        endTime = timePicked;
      });
    }
  }

  DateTime getDate(Timestamp timestamp) {
    DateTime originalDate = DateTime.parse(timestamp.toDate().toString());
    print(DateTime(originalDate.year, originalDate.month, originalDate.day).toString());
    return DateTime(originalDate.year, originalDate.month, originalDate.day);
  }

  TimeOfDay getHoursAndMin(Timestamp timestamp) {
    DateTime originalDate = DateTime.parse(timestamp.toDate().toString());
    print(TimeOfDay(hour: originalDate.hour, minute: originalDate.minute).toString());
    return TimeOfDay(hour: originalDate.hour, minute: originalDate.minute);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('Facilities')
            .doc(referenceCode)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: bgColor,
              body: Stack(
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: CustomPaint(
                      painter: pathPainter(),
                    ),
                  ),
                  Positioned(
                    top: 25,
                    left: 15,
                    child: IconButton(
                      key: Key('Back Button'),
                      icon: Icon(Icons.arrow_back_rounded,
                          color: KERed, size: 30),
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
                        logOutNotice(context);
                      },
                    ),
                  ),
                  Positioned(
                    top: 75,
                    left: 25,
                    child: Text(
                      "Edit My Booking",
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
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Text(
                        "Modify this existing booking or completely delete it.",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: KERed),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Your booking has been deleted.',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: KERed),
                    ),
                  )
                ],
              ),
            );
          }
          DocumentSnapshot bookingData = snapshot.data;
          return Scaffold(
              backgroundColor: bgColor,
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: CustomPaint(
                          painter: pathPainter(),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        left: 15,
                        child: IconButton(
                          key: Key('Back Button'),
                          icon: Icon(Icons.arrow_back_rounded,
                              color: KERed, size: 30),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 25,
                        right: 55,
                        child: IconButton(
                          icon:
                          Icon(Icons.home_rounded, color: KERed, size: 30),
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
                            logOutNotice(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 75,
                        left: 25,
                        child: Text(
                          "Edit My Booking",
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
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Text(
                            "Modify this existing booking or completely delete it.",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: KERed),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 180,
                        left: 20,
                        right: 20,
                        child: Form(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.09,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: KELightRed,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 40.0,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      color: KERed),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on_rounded,
                                        color: bgColor,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection(
                                              'Available Facilities')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Text(
                                                  'Loading, please wait');
                                            }
                                            return Expanded(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.0),
                                                child: DropdownButtonFormField(
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                      InputBorder.none),
                                                  hint: Text(
                                                    bookingData['Venue'],
                                                    style: TextStyle(
                                                        color: KERed,
                                                        fontSize: 19.0,
                                                        fontFamily:
                                                        'Montserrat',
                                                        fontWeight:
                                                        FontWeight.w700),
                                                  ),
                                                  dropdownColor: KELightRed,
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_drop_down_rounded,
                                                    color: KERed,
                                                  ),
                                                  iconSize: 25.0,
                                                  isExpanded: true,
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: KERed,
                                                      fontSize: 19.0,
                                                      fontWeight:
                                                      FontWeight.w700),
                                                  value: venueChoose = bookingData['Venue'],
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      venueChoose = newValue;
                                                    });
                                                  },
                                                  items: snapshot.data.docs.map<
                                                      DropdownMenuItem<
                                                          String>>(
                                                          (DocumentSnapshot
                                                      document) {
                                                        return new DropdownMenuItem<
                                                            String>(
                                                          value: document['Value'],
                                                          child: Text(
                                                            document['Value'],
                                                            style: TextStyle(
                                                              fontFamily:
                                                              'Montserrat',
                                                              fontSize: 19.0,
                                                              color: KERed,
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                  validator: (value) {
                                                    if (value == null) {
                                                      setState(() {
                                                        venueChoose = bookingData['Venue'];
                                                      });
                                                    }
                                                  },
                                                ),
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
                        top: 260,
                        left: 20,
                        right: 20,
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.09,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: KELightRed,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 40.0,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      color: KERed),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.date_range_rounded,
                                        color: bgColor,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 20.0),
                                    child: dateChosen != null
                                        ? Text(
                                      dateChosen.day.toString() +
                                          ' - ' +
                                          dateChosen.month.toString() +
                                          ' - ' +
                                          dateChosen.year.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 19,
                                          color: KERed),
                                    )
                                        : Text(
                                      bookingData['Date'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 19,
                                          color: KERed),
                                    )),
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
                        top: 340,
                        left: 20,
                        right: 20,
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.09,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: KELightRed,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 40.0,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      color: KERed),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        color: bgColor,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 20.0),
                                    child: startTime != null
                                        ? Text(
                                      'Start Time: ' +
                                          startTime.format(context),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 19,
                                          color: KERed),
                                    )
                                        : Text(
                                      'Start Time: ' + bookingData['Start time'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 19,
                                          color: KERed),
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            selectStartTimePicker(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 420,
                        left: 20,
                        right: 20,
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.09,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: KELightRed,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 40.0,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      color: KERed),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        color: bgColor,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 20.0),
                                    child: endTime != null
                                        ? Text(
                                      'End Time: ' +
                                          endTime.format(context),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 19,
                                          color: KERed),
                                    )
                                        :
                                    Text(
                                      'End Time: ' + bookingData['End time'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 19,
                                          color: KERed),
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            selectEndTimePicker(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 500,
                        left: 20,
                        right: 20,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.09,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: KELightRed,
                          ),
                          child: Row(children: [
                            Container(
                              height: 40.0,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  color: KERed),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sports_tennis_rounded,
                                    color: bgColor,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: TextFormField(
                                  controller: ccaField..text = bookingData['CcaBlock'],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    filled: true,
                                    fillColor: KELightRed,
                                    labelText: "CCA/ Block",
                                    labelStyle: TextStyle(
                                        color: KERed,
                                        fontSize: 19,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        ccaField = bookingData['CcaBlock'];
                                      });
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Positioned(
                        top: 580,
                        left: 20,
                        right: 20,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.09,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: KELightRed,
                          ),
                          child: Row(children: [
                            Container(
                              height: 40.0,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  color: KERed),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.people_outline_rounded,
                                    color: bgColor,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: TextFormField(
                                  controller: numOfPax..text = bookingData['Number of Pax'],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    filled: true,
                                    fillColor: KELightRed,
                                    labelText: 'Number of People',
                                    labelStyle: TextStyle(
                                        color: KERed,
                                        fontSize: 19,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        numOfPax = bookingData['Number of Pax'];
                                      });
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Positioned(
                        top: 645,
                        left: 20,
                        right: 20,
                        child: ElevatedButton(
                          onPressed: () {
                            if (venueChoose == null) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: KELightYellow,
                                      title: Text(
                                        "Error",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: KERed),
                                      ),
                                      content: Text(
                                        'Choose a valid venue',
                                        style: TextStyle(
                                            fontSize: 18, color: KERed),
                                        textAlign: TextAlign.left,
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(KERed)),
                                          child: Text("Ok",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: KELightYellow,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                            } if(dateChosen == null) {
                                dateChosen = getDate(bookingData['Start Time (Timestamp)']);
                            } if(startTime == null) {
                              startTime = getHoursAndMin(bookingData['Start Time (Timestamp)']);
                            } if(endTime == null) {
                              endTime = getHoursAndMin(
                                  bookingData['End Time (Timestamp)']);
                            }
                            _formKey.currentState.validate();
                            if (_formKey.currentState.validate()) {
                              editBooking();
                            }
                          },
                          child: Center(
                              child: Text(
                                'Save Changes',
                                style: TextStyle(
                                    color: KERed,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700),
                              )),
                        ),
                      ),
                      Positioned(
                        top: 690,
                        left: 20,
                        right: 20,
                        child: ElevatedButton(onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: KELightYellow,
                                  title: Text(
                                    "Delete Booking",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: KERed),
                                  ),
                                  content: Text(
                                    'Are you sure you want to delete this booking?',
                                    style: TextStyle(
                                        fontSize: 18, color: KERed),
                                    textAlign: TextAlign.left,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .all<Color>(KERed)),
                                      child: Text("Ok",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: KELightYellow,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left),
                                      onPressed: () {
                                        setState(() {
                                          deleteBooking();
                                        });
                                        Navigator.popUntil(
                                            context,
                                            ModalRoute.withName("Manage Bookings Page"));                                      },
                                    )
                                  ],
                                );
                              });
                        },
                          style: ElevatedButton.styleFrom(primary: KERed),
                          child: Center(
                                child: Text(
                                  'Delete Booking',
                                  style: TextStyle(
                                      color: KELightYellow,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700),
                                )),),
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  void logOutNotice(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Are you sure you want to Log Out?", style: TextStyle(fontWeight: FontWeight.bold, color: KERed),),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            print("Cancel");
            Navigator.of(context).pop(false);
          },
          child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, color: KERed),),
        ),
        FlatButton(
          onPressed: () {
            print("Logout");
            FirebaseAuth auth = FirebaseAuth.instance;
            auth.signOut().then((res) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => EmailLogIn()),
                      (Route<dynamic> route) => false);
            });
          },
          child: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold, color: KERed),),
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void deleteBooking() async {
    FirebaseFirestore.instance.collection('Facilities').doc(referenceCode).delete();
  }

  void editBooking() async {
    DateTime chosenStart = DateTime(dateChosen.year, dateChosen.month,
        dateChosen.day, startTime.hour, startTime.minute);
    DateTime chosenEnd = DateTime(dateChosen.year, dateChosen.month,
        dateChosen.day, endTime.hour, endTime.minute);
    List<TimePair> ListOfTimes = [];
    if (chosenStart.isAfter(chosenEnd)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: KELightYellow,
              title: Text(
                "Do you know your timings?",
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: KERed),
              ),
              content: Text(
                'Start Time is after End Time!',
                style: TextStyle(fontSize: 18, color: KERed),
                textAlign: TextAlign.left,
              ),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(KERed)),
                  child: Text("Ok",
                      style: TextStyle(
                          fontSize: 18,
                          color: KELightYellow,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                  onPressed: () {
                    setState(() {
                      startTime = null;
                      endTime = null;
                    });
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    } else {
      FirebaseFirestore.instance
          .collection('Facilities')
          .where('Venue', isEqualTo: venueChoose).where('Reference Code', isNotEqualTo: referenceCode)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          int count = querySnapshot.docs.length;
          querySnapshot.docs.forEach((doc) {
            Timestamp docStartTime = doc['Start Time (Timestamp)'];
            Timestamp docEndTime = doc['End Time (Timestamp)'];
            TimePair docTimePair = new TimePair(docStartTime, docEndTime);
            ListOfTimes.add(docTimePair);
          });
          for (TimePair pair in ListOfTimes) {
            if (pair.isBetween(chosenStart) || pair.isBetween(chosenEnd)) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: KELightYellow,
                      title: Text(
                        "Slot already taken!",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: KERed),
                      ),
                      content: Text(
                        'Choose another time slot please',
                        style: TextStyle(fontSize: 18, color: KERed),
                        textAlign: TextAlign.left,
                      ),
                      actions: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(KERed)),
                          child: Text("Ok",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: KELightYellow,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left),
                          onPressed: () {
                            setState(() {
                              startTime = null;
                              endTime = null;
                            });
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
              break;
            } else {
              count--; // minus the document count
            }
          }
          if (count == 0) {
            // only if all documents traversed, then add booking
            FirebaseFirestore.instance.collection('Facilities').doc(referenceCode).update({
              'Date': dateChosen.day.toString() +
                  '-' +
                  dateChosen.month.toString() +
                  '-' +
                  dateChosen.year.toString(),
              'Start time':
              TimeOfDay(hour: chosenStart.hour, minute: chosenStart.minute)
                  .format(context),
              'End time':
              TimeOfDay(hour: chosenEnd.hour, minute: chosenEnd.minute)
                  .format(context),
              'Venue': venueChoose,
              'Start Time (Timestamp)': chosenStart,
              'End Time (Timestamp)': chosenEnd,
              'CcaBlock': ccaField.text,
              'Number of Pax': numOfPax.text,
              'user': this.user.uid,
            });
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BookingConfirmationPage(
                          venueChoose,
                          dateChosen.day.toString() +
                              '-' +
                              dateChosen.month.toString() +
                              '-' +
                              dateChosen.year.toString(),
                          TimeOfDay(
                              hour: chosenStart.hour,
                              minute: chosenStart.minute)
                              .format(context),
                          TimeOfDay(
                              hour: chosenEnd.hour,
                              minute: chosenEnd.minute)
                              .format(context),
                          numOfPax.text,
                          ccaField.text,
                        )));
          }
        } else {
          // list is empty
          FirebaseFirestore.instance.collection('Facilities').add({
            'Date': dateChosen.day.toString() +
                '-' +
                dateChosen.month.toString() +
                '-' +
                dateChosen.year.toString(),
            'Start time':
            TimeOfDay(hour: chosenStart.hour, minute: chosenStart.minute)
                .format(context),
            'End time':
            TimeOfDay(hour: chosenEnd.hour, minute: chosenEnd.minute)
                .format(context),
            'Venue': venueChoose,
            'Start Time (Timestamp)':
            chosenStart.subtract(const Duration(hours: 8)),
            'End Time (Timestamp)':
            chosenEnd.subtract(const Duration(hours: 8)),
            'CcaBlock': ccaField.text,
            'Number of Pax': numOfPax.text,
            'user': this.user.uid,
          }).then((value) =>
              FirebaseFirestore.instance
                  .collection('Facilities')
                  .doc(value.id)
                  .update({'Reference Code': value.id}));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BookingConfirmationPage(
                        venueChoose,
                        dateChosen.day.toString() +
                            '-' +
                            dateChosen.month.toString() +
                            '-' +
                            dateChosen.year.toString(),
                        TimeOfDay(
                            hour: chosenStart.hour,
                            minute: chosenStart.minute)
                            .format(context),
                        TimeOfDay(
                            hour: chosenEnd.hour, minute: chosenEnd.minute)
                            .format(context),
                        numOfPax.text,
                        ccaField.text,
                      )));
        }
      });
    }
  }
}

class TimePair {
  Timestamp startTime, endTime;
  DateTime start, end;

  TimePair(this.startTime, this.endTime) {
    this.start = startTime.toDate();
    this.end = endTime.toDate();
  }

  void printTimes() {
    print(start);
    print(end);
  }

  bool isBetween(DateTime chosenTime) {
    return (chosenTime.isAfter(start) && chosenTime.isBefore(end));
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Screens/FacilitiesBookingPage.dart';
import 'package:keviiapp/signup.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';

class AddBooking extends StatefulWidget {
  static final now = DateTime.now();
  final dropdownDatePicker = DropdownDatePicker(
    firstDate: ValidDate(year: now.year, month: now.month, day: now.day),
    lastDate: ValidDate(year: now.year + 1, month: 12, day: 31),
    textStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontWeight: FontWeight.bold),
    dropdownColor: Colors.amber,
    dateHint: DateHint(year: 'year', month: 'month', day: 'day'),
    ascending: true,
  );
  @override
  _AddBookingState createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  String title = 'Add a Booking',
      venueChoose,
      startChoose,
      endChoose,
      periodChoose;

  _AddBookingState();

  @override
  void initState() {
    super.initState();
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
          mainAxisAlignment: MainAxisAlignment.start,
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
                        'Choose Venue',
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 22.0,
                            fontFamily: 'Montserrat'),
                      ),
                      dropdownColor: Colors.grey,
                      icon: Icon(
                        Icons.arrow_drop_down_circle_sharp,
                        color: Colors.amber,
                      ),
                      iconSize: 22.0,
                      isExpanded: true,
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
                              fontSize: 15.0,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Time')
                        .orderBy('Hour')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading, please wait');
                      }
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: DropdownButton(
                          hint: Text(
                            'Choose Start Time',
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 22.0,
                                fontFamily: 'Montserrat'),
                          ),
                          dropdownColor: Colors.grey,
                          icon: Icon(
                            Icons.arrow_drop_down_circle_sharp,
                            color: Colors.amber,
                          ),
                          iconSize: 22.0,
                          isExpanded: false,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.amber,
                            fontSize: 22.0,
                          ),
                          value: startChoose,
                          onChanged: (newValue) {
                            setState(() {
                              startChoose = newValue;
                            });
                          },
                          items: snapshot.data.docs
                              .map<DropdownMenuItem<String>>(
                                  (DocumentSnapshot document) {
                            return new DropdownMenuItem<String>(
                              value: document['Hour'].toString(),
                              child: Text(
                                document['Hour'].toString(),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15.0,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                SizedBox(width: 6.0),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Period')
                        .orderBy('Period')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading, please wait');
                      }
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: DropdownButton(
                          hint: Text(
                            'AM/PM',
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 22.0,
                                fontFamily: 'Montserrat'),
                          ),
                          dropdownColor: Colors.grey,
                          icon: Icon(
                            Icons.arrow_drop_down_circle_sharp,
                            color: Colors.amber,
                          ),
                          iconSize: 22.0,
                          isExpanded: false,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.amber,
                            fontSize: 22.0,
                          ),
                          value: periodChoose,
                          onChanged: (newValue) {
                            setState(() {
                              periodChoose = newValue;
                            });
                          },
                          items: snapshot.data.docs
                              .map<DropdownMenuItem<String>>(
                                  (DocumentSnapshot document) {
                            return new DropdownMenuItem<String>(
                              value: document['Period'],
                              child: Text(
                                document['Period'],
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15.0,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    })
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Time')
                        .orderBy('Hour')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading, please wait');
                      }
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: DropdownButton(
                          hint: Text(
                            'Choose End Time',
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 22.0,
                                fontFamily: 'Montserrat'),
                          ),
                          dropdownColor: Colors.grey,
                          icon: Icon(
                            Icons.arrow_drop_down_circle_sharp,
                            color: Colors.amber,
                          ),
                          iconSize: 22.0,
                          isExpanded: false,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.amber,
                            fontSize: 22.0,
                          ),
                          value: endChoose,
                          onChanged: (newValue) {
                            setState(() {
                              endChoose = newValue;
                            });
                          },
                          items: snapshot.data.docs
                              .map<DropdownMenuItem<String>>(
                                  (DocumentSnapshot document) {
                            return new DropdownMenuItem<String>(
                              value: document['Hour'].toString(),
                              child: Text(
                                document['Hour'].toString(),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15.0,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                SizedBox(width: 6.0),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Period')
                        .orderBy('Period')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading, please wait');
                      }
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: DropdownButton(
                          hint: Text(
                            'AM/PM',
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 22.0,
                                fontFamily: 'Montserrat'),
                          ),
                          dropdownColor: Colors.grey,
                          icon: Icon(
                            Icons.arrow_drop_down_circle_sharp,
                            color: Colors.amber,
                          ),
                          iconSize: 22.0,
                          isExpanded: false,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.amber,
                            fontSize: 22.0,
                          ),
                          value: periodChoose,
                          onChanged: (newValue) {
                            setState(() {
                              periodChoose = newValue;
                            });
                          },
                          items: snapshot.data.docs
                              .map<DropdownMenuItem<String>>(
                                  (DocumentSnapshot document) {
                            return new DropdownMenuItem<String>(
                              value: document['Period'],
                              child: Text(
                                document['Period'],
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15.0,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    })
              ],
            ),
            SizedBox(height: 5.0),
            Column(
              children: <Widget>[
                widget.dropdownDatePicker,
              ],
            ),
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
    FirebaseFirestore.instance.collection('Facilities').add({
      'Date': widget.dropdownDatePicker.getDate(),
      'Start time': startChoose + periodChoose,
      'End time': endChoose + periodChoose,
      'Venue': venueChoose
    });
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => FacilitiesBookingPage()));
  }
}

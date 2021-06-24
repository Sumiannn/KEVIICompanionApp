import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Panels/bookingPagePanel.dart';
import 'package:keviiapp/Facilities/AddBooking.dart';
import 'package:keviiapp/colorScheme.dart';

import '../SignInSignUp/email_login.dart';
import '../HomePage/home.dart';

class FacilitiesBookingPage extends StatelessWidget {
  final title = "Check current bookings";

  FacilitiesBookingPage({this.firestore});
  final FirebaseFirestore firestore;

  DateTime isNow() {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      0,
      0,
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime Today = isNow();
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                key: Key('Cover Image'),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  'https://scontent.fsin7-1.fna.fbcdn.net/v/t1.6435-9/40773051_735925123423298_3456762337506099200_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=e3f864&_nc_ohc=cYV5LA7oRwAAX-JegYv&_nc_ht=scontent.fsin7-1.fna&oh=f6574ac78423be012faf59f4cc022025&oe=60E6D081',
                  alignment: Alignment.topLeft,
                  fit: BoxFit.fitWidth,
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
                top: 230,
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: bgColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: Text(
                            "Current Bookings",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: KERed),
                          ),
                        ),
                      ],
                    )),
              ),
              Positioned.fill(
                top: 300,
                child: Container(
                    child: DefaultTabController(
                  length: 7,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600),
                        indicatorColor: KEYellow,
                        unselectedLabelColor: KELightRed,
                        labelColor: KERed,
                        labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        tabs: [
                          Tab(
                            text: 'MPC',
                          ),
                          Tab(
                            text: 'Comm Hall',
                          ),
                          Tab(
                            text: 'Squash Courts',
                          ),
                          Tab(
                            text: 'Tennis Courts',
                          ),
                          Tab(
                            text: 'Dance Studio',
                          ),
                          Tab(
                            text: 'Heritage Room',
                          ),
                          Tab(
                            text: 'Dining Hall',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: TabBarView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("Facilities")
                                      .where('Venue', isEqualTo: 'MPC')
                                      .where('Start Time (Timestamp)',
                                          isGreaterThanOrEqualTo:
                                              Timestamp.fromDate(Today))
                                      .orderBy('Start Time (Timestamp)')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data.docs.length == 0) {
                                      return Center(
                                          child: Text(
                                        'No bookings currently',
                                        style: TextStyle(
                                            color: KERed,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25),
                                      ));
                                    }
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 16.0),
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot bookings =
                                            snapshot.data.docs[index];
                                        return bookingPagePanel(
                                          bookings['Venue'],
                                          bookings['Date'],
                                          bookings['Start time'],
                                          bookings['End time'],
                                          bookings['Start Time (Timestamp)'],
                                          bookings['Number of Pax'],
                                          bookings['CcaBlock'],
                                          bookings['Reference Code'],
                                        );
                                      },
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("Facilities")
                                      .where('Venue', isEqualTo: 'Comm Hall')
                                      .where('Start Time (Timestamp)',
                                          isGreaterThanOrEqualTo:
                                              Timestamp.fromDate(Today))
                                      .orderBy('Start Time (Timestamp)')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data.docs.length == 0) {
                                      return Center(
                                          child: Text(
                                        'No bookings currently',
                                        style: TextStyle(
                                            color: KERed,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25),
                                      ));
                                    }
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 16.0),
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot bookings =
                                            snapshot.data.docs[index];
                                        return bookingPagePanel(
                                          bookings['Venue'],
                                          bookings['Date'],
                                          bookings['Start time'],
                                          bookings['End time'],
                                          bookings['Start Time (Timestamp)'],
                                          bookings['Number of Pax'],
                                          bookings['CcaBlock'],
                                          bookings['Reference Code'],
                                        );
                                      },
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("Facilities")
                                      .where('Venue',
                                          isEqualTo: 'Squash Courts')
                                      .where('Start Time (Timestamp)',
                                          isGreaterThanOrEqualTo:
                                              Timestamp.fromDate(Today))
                                      .orderBy('Start Time (Timestamp)')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data.docs.length == 0) {
                                      return Center(
                                          child: Text(
                                        'No bookings currently',
                                        style: TextStyle(
                                            color: KERed,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25),
                                      ));
                                    }
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 16.0),
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot bookings =
                                            snapshot.data.docs[index];
                                        return bookingPagePanel(
                                          bookings['Venue'],
                                          bookings['Date'],
                                          bookings['Start time'],
                                          bookings['End time'],
                                          bookings['Start Time (Timestamp)'],
                                          bookings['Number of Pax'],
                                          bookings['CcaBlock'],
                                          bookings['Reference Code'],
                                        );
                                      },
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("Facilities")
                                      .where('Venue',
                                          isEqualTo: 'Tennis Courts')
                                      .where('Start Time (Timestamp)',
                                          isGreaterThanOrEqualTo:
                                              Timestamp.fromDate(
                                                  DateTime.now()))
                                      .orderBy('Start Time (Timestamp)')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data.docs.length == 0) {
                                      return Center(
                                          child: Text(
                                        'No bookings currently',
                                        style: TextStyle(
                                            color: KERed,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25),
                                      ));
                                    }
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 16.0),
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot bookings =
                                            snapshot.data.docs[index];
                                        return bookingPagePanel(
                                          bookings['Venue'],
                                          bookings['Date'],
                                          bookings['Start time'],
                                          bookings['End time'],
                                          bookings['Start Time (Timestamp)'],
                                          bookings['Number of Pax'],
                                          bookings['CcaBlock'],
                                          bookings['Reference Code'],
                                        );
                                      },
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("Facilities")
                                      .where('Venue', isEqualTo: 'Dance Studio')
                                      .where('Start Time (Timestamp)',
                                          isGreaterThanOrEqualTo:
                                              Timestamp.fromDate(Today))
                                      .orderBy('Start Time (Timestamp)')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data.docs.length == 0) {
                                      return Center(
                                          child: Text(
                                        'No bookings currently',
                                        style: TextStyle(
                                            color: KERed,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25),
                                      ));
                                    }
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 16.0),
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot bookings =
                                            snapshot.data.docs[index];
                                        return bookingPagePanel(
                                          bookings['Venue'],
                                          bookings['Date'],
                                          bookings['Start time'],
                                          bookings['End time'],
                                          bookings['Start Time (Timestamp)'],
                                          bookings['Number of Pax'],
                                          bookings['CcaBlock'],
                                          bookings['Reference Code'],
                                        );
                                      },
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("Facilities")
                                      .where('Venue',
                                          isEqualTo: 'Heritage Room')
                                      .where('Start Time (Timestamp)',
                                          isGreaterThanOrEqualTo:
                                              Timestamp.fromDate(Today))
                                      .orderBy('Start Time (Timestamp)')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data.docs.length == 0) {
                                      return Center(
                                          child: Text(
                                        'No bookings currently',
                                        style: TextStyle(
                                            color: KERed,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25),
                                      ));
                                    }
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 16.0),
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot bookings =
                                            snapshot.data.docs[index];
                                        return bookingPagePanel(
                                          bookings['Venue'],
                                          bookings['Date'],
                                          bookings['Start time'],
                                          bookings['End time'],
                                          bookings['Start Time (Timestamp)'],
                                          bookings['Number of Pax'],
                                          bookings['CcaBlock'],
                                          bookings['Reference Code'],
                                        );
                                      },
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("Facilities")
                                      .where('Venue', isEqualTo: 'Dining Hall')
                                      .where('Start Time (Timestamp)',
                                          isGreaterThanOrEqualTo:
                                              Timestamp.fromDate(
                                                  DateTime.now()))
                                      .orderBy('Start Time (Timestamp)')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data.docs.length == 0) {
                                      return Center(
                                          child: Text(
                                        'No bookings currently',
                                        style: TextStyle(
                                            color: KERed,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25),
                                      ));
                                    }
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 16.0),
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot bookings =
                                            snapshot.data.docs[index];
                                        return bookingPagePanel(
                                          bookings['Venue'],
                                          bookings['Date'],
                                          bookings['Start time'],
                                          bookings['End time'],
                                          bookings['Start Time (Timestamp)'],
                                          bookings['Number of Pax'],
                                          bookings['CcaBlock'],
                                          bookings['Reference Code'],
                                        );
                                      },
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

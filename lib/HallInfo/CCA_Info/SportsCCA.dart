import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../SignInSignUp/email_login.dart';
import '../../HomePage/home.dart';
import '../../colorScheme.dart';

class SportsCCA extends StatefulWidget {
  SportsCCA();

  @override
  _SportsCCAState createState() => _SportsCCAState();
}

class _SportsCCAState extends State<SportsCCA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                top: 0,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/image/SportsPhoto.jpeg',
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                top: 25,
                left: 15,
                child: IconButton(
                  key: Key('Back Button'),
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
                    logOutNotice(context);
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
                            "Sports CCAs",
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
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('CCA Information')
                            .where('Type', isEqualTo: 'Sports')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData ||
                              snapshot.data.docs.length == 0) {
                            return Text('Loading Please Wait');
                          }
                          List<Tab> tabs = [];
                          List<Widget> tabBarViews = [];

                          snapshot.data.docs.forEach((doc) {
                            tabs.add(Tab(text: doc['CCA Name']));
                            tabBarViews.add(
                              ListView(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        doc['ImageURL'],
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.22,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.005,
                                    decoration:
                                        BoxDecoration(color: KELightYellow),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.10,
                                    child: Row(
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  doc['CCA Name'],
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: KERed),
                                                  textAlign: TextAlign.left,
                                                ))),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.38,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'CCA Type',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(doc['Commitment'],
                                                  style:
                                                      TextStyle(fontSize: 16))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.005,
                                    decoration:
                                        BoxDecoration(color: KELightYellow),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, top: 10),
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: KELightRed,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      doc['Description'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: KERed,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                          return DefaultTabController(
                            length: snapshot.data.docs.length,
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
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  tabs: tabs,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.50,
                                  child: TabBarView(
                                      key: Key('tabBarView'),
                                      children: tabBarViews),
                                )
                                /*
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
                                              .orderBy('Start Time (Timestamp)')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData || snapshot.data.docs.length == 0) {
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
                                                );
                                              },
                                            );
                                          }
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("Facilities")
                                              .where('Venue', isEqualTo: 'Comm Hall')
                                              .orderBy('Start Time (Timestamp)')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData || snapshot.data.docs.length == 0) {
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
                                                );
                                              },
                                            );
                                          }
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("Facilities")
                                              .where('Venue', isEqualTo: 'Squash Courts')
                                              .orderBy('Start Time (Timestamp)')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData || snapshot.data.docs.length == 0) {
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
                                                );
                                              },
                                            );
                                          }
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("Facilities")
                                              .where('Venue',
                                              isEqualTo: 'Tennis Courts')
                                              .orderBy('Start Time (Timestamp)')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return ListView.builder(
                                                shrinkWrap: true,
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
                                                  );
                                                },
                                              );
                                            }
                                            return Center(
                                                child: Text(
                                                  'No bookings currently',
                                                  style: TextStyle(
                                                      color: KERed,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 30),
                                                ));
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("Facilities")
                                              .where('Venue', isEqualTo: 'Dance Studio')
                                              .orderBy('Start Time (Timestamp)')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData || snapshot.data.docs.length == 0) {
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
                                                );
                                              },
                                            );
                                          }
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("Facilities")
                                              .where('Venue', isEqualTo: 'Heritage Room')
                                              .orderBy('Start Time (Timestamp)')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData || snapshot.data.docs.length == 0) {
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
                                                );
                                              },
                                            );
                                          }
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("Facilities")
                                              .where('Venue', isEqualTo: 'Dining Hall')
                                              .orderBy('Start Time (Timestamp)')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData || snapshot.data.docs.length == 0) {
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
                                                );
                                              },
                                            );
                                          }
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              */
                              ],
                            ),
                          );
                        })),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void logOutNotice(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Are you sure you want to Log Out?"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            print("Cancel");
            Navigator.of(context).pop(false);
          },
          child: Text('Cancel', style: TextStyle(color: Colors.black),),
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
          child: Text('Logout', style: TextStyle(color: Colors.black),),
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
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
}

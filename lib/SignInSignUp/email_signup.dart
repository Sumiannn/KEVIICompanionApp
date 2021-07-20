import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/colorScheme.dart';
import 'package:keviiapp/Auth.dart';


import '../HomePage/home.dart';

class EmailSignUp extends StatefulWidget {
  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Users");
  TextEditingController emailController = TextEditingController();
  TextEditingController nusidController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Form(
        key: _formKey,
        child: Container(
          child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    painter: pathPainter(),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height*0.6,
                  child: Container(
                    height: 307,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Image.asset(
                        'assets/image/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 25,
                    left: 15,
                    child: IconButton(
                      key: Key('Back Button'),
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          size: 30,
                          color: KERed,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        })),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.53,
                  child: Container(
                    padding: EdgeInsets.all(50.0),
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                        child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: KERed,
                        fontFamily: 'Montserrat',
                        fontSize: 35.0,
                        fontWeight: FontWeight.w900,
                      ),
                    )),
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width * 0.9,
                  bottom: MediaQuery.of(context).size.height * 0.017 ,
                  left: MediaQuery.of(context).size.width * 0.05,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.57,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: KELightYellow,
                            prefixIcon: Icon(
                              Icons.email,
                              color: KERed,
                            ),
                            hintText: "Enter NUS Email",
                            hintStyle: TextStyle(
                                color: KERed,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter your NUS Email';
                            } else if (!value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: nusidController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: KELightYellow,
                            prefixIcon: Icon(
                              Icons.person,
                              color: KERed,
                            ),
                            hintText: "Enter NUSID (E.g. E0123456)",
                            hintStyle: TextStyle(
                                color: KERed,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.length != 8) {
                              return 'Not a valid NUSID';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: roomController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: KELightYellow,
                            prefixIcon: Icon(
                              Icons.sensor_door_rounded,
                              color: KERed,
                            ),
                            hintText: "Enter Room Number",
                            hintStyle: TextStyle(
                                color: KERed,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.length != 4) {
                              return 'Not a valid Room Number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: KELightYellow,
                            prefixIcon: Icon(
                              Icons.looks_one_rounded,
                              color: KERed,
                            ),
                            hintText: "First Name",
                            hintStyle: TextStyle(
                                color: KERed,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide your first name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: KELightYellow,
                            prefixIcon: Icon(
                              Icons.looks_two_rounded,
                              color: KERed,
                            ),
                            hintText: "Last Name",
                            hintStyle: TextStyle(
                                color: KERed,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide your last name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: KELightYellow,
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: KERed,
                            ),
                            hintText: "Choose a password",
                            hintStyle: TextStyle(
                                color: KERed,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15,),
                        isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                          key: Key('Sign Up Button'),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide.none,
                              )),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(KERed)),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              String userResult = await Auth(auth: FirebaseAuth.instance).createAccount(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              if (userResult == 'Success') {
                                print(roomController.text);
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(firebaseAuth.currentUser.uid)
                                    .set({
                                  "email": emailController.text,
                                  "room": roomController.text,
                                  "nusid": nusidController.text,
                                  'last name': lastNameController.text,
                                  'first name' : firstNameController.text
                                });
                                String loginResult = await Auth(auth: FirebaseAuth.instance).signIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                if (loginResult == 'Success') {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => Home(uid: firebaseAuth.currentUser.uid)));
                                }
                              } else {
                                print(userResult);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: KELightYellow,
                                        title: Text("Error", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: KERed),),
                                        content: Text(userResult, style: TextStyle(fontSize: 18, color: KERed), textAlign: TextAlign.left,),
                                        actions: [
                                          ElevatedButton(
                                            style: ButtonStyle(backgroundColor:  MaterialStateProperty.all<Color>(
                                                KERed)),
                                            child: Text("Retry", style: TextStyle(fontSize: 18, color: KELightYellow, fontWeight: FontWeight.bold), textAlign: TextAlign.left),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: KEYellow, fontFamily: 'Montserrat'),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ),
        ),
        ),
      );
  }

  void registerToFb() {
    firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .catchError((err) {
      setState(() {
        isLoading = false;
      });
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: KELightYellow,
              title: Text("Error", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: KERed),),
              content: Text(err.message, style: TextStyle(fontSize: 18, color: KERed), textAlign: TextAlign.left,),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(backgroundColor:  MaterialStateProperty.all<Color>(
                      KERed)),
                  child: Text("Retry", style: TextStyle(fontSize: 18, color: KELightYellow, fontWeight: FontWeight.bold), textAlign: TextAlign.left),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }).then((result) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseAuth.currentUser.uid)
          .set({
        "email": emailController.text,
        "room": roomController.text,
        "nusid": nusidController.text,
      }).then((res) {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((result) {
          isLoading = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home(uid: result.user.uid)),
          );
        });
      }).catchError((err) {
        setState(() {
          isLoading = false;
        });
        print(err.message);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(err.message),
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    nusidController.dispose();
    emailController.dispose();
    passwordController.dispose();
    roomController.dispose();
  }
}

class pathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = KELightRed;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height * 0.45);
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

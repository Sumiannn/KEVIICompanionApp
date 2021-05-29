import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Screens/email_login.dart';

import 'home.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF820312),
        body: SingleChildScrollView(
          child: Column( children: [
            SizedBox(height: 100,),
            Container(
              width: 200.0,
              height: 200.0,
              child: Image.asset('assets/image/KE2.jpg', fit: BoxFit.cover,),
            ),
            Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[

                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Enter NUS Email",
                            hintStyle: TextStyle(
                                color: Colors.amber,
                                fontFamily: 'Montserrat'
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.amber),
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
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          controller: nusidController,
                          decoration: InputDecoration(
                            hintText: "Enter NUSID",
                            hintStyle: TextStyle(
                                color: Colors.amber,
                                fontFamily: 'Montserrat'
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.amber),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Room Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical:16.0, horizontal: 16.0),
                        child: TextFormField(
                          controller: roomController,
                          decoration: InputDecoration(
                            hintText: "Enter Room Number",
                            hintStyle: TextStyle(
                                color: Colors.amber,
                                fontFamily: 'Montserrat'
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.amber),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Room Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                                color: Colors.amber,
                                fontFamily: 'Montserrat'
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.amber),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Password';
                            } else if (value.length < 6) {
                              return 'Password must be atleast 6 characters!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              registerToFb(); //sync to firebase
                            }
                          },
                          child: Text('Sign Up',
                            style: TextStyle(
                                fontFamily: 'Montserrat'
                            ),
                          ),
                        ),
                      )
                    ]))),
          ],

          )
        ));
  }

  void registerToFb() {
    firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((result) {
      FirebaseFirestore.instance.collection("users").doc(firebaseAuth.currentUser.uid).set({
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
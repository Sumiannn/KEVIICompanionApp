import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/email_signup.dart';
import 'package:keviiapp/signup.dart';

import 'home.dart';

class EmailLogIn extends StatefulWidget {
  @override
  _EmailLogInState createState() => _EmailLogInState();
}

class _EmailLogInState extends State<EmailLogIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Login",
          style: TextStyle(fontFamily: 'Montserrat'),),
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  SizedBox(height:200.0),
                  const Image(image:
                    NetworkImage('https://se-infra-imageserver2.azureedge.net/clink/images/04b73bd3-9e29-41e6-a161-6591954ab213687f01de-568a-4a50-abf9-d40715fb785f.png?preset=med-sq')
                  ),
                  SizedBox(height:30.0),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
                          return 'Enter Email Address';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address!';
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
                          logInToFb();
                        }
                      },
                      child: Text('Log In',
                      style: TextStyle(fontFamily: 'Montserrat'),),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                          child: Text("New KEViian? Sign Up Here",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                  decoration: TextDecoration.underline,
                                  color: Colors.amber)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EmailSignUp()),
                            );
                          }))
                ]))));
  }

  void logInToFb() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((result) {
      isLoading = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home(uid: result.user.uid)),
      );
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }
}
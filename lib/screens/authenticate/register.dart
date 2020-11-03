import 'package:flutter/material.dart';
import 'package:calmity/screens/authenticate/sign_in.dart';
import 'package:calmity/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:calmity/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  String _name = "";
  String _mobile = "";
  String profile = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            color: Colors.white,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: EdgeInsets.all(23),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "REGISTER",
                        style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Futura',
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (val) => val.length == null
                                  ? "Please Enter Name"
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  _name = val;
                                });
                              },
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent, width: 2.0)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent, width: 2.0)),
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.black87)),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: TextFormField(
                                validator: (val) =>
                                    val.isEmpty ? "Enter an email" : null,
                                onChanged: (val) {
                                  setState(() {
                                    _email = val;
                                  });
                                },
                                cursorColor: Colors.black,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 2.0)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 2.0)),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        fontSize: 15, color: Colors.black87)),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (val) => val.length < 8
                                  ? "8 characters minimum"
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  _password = val;
                                });
                              },
                              cursorColor: Colors.black,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent, width: 2.0)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent, width: 2.0)),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.black87)),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (val) => val.length != 10
                                  ? "Please Enter Valid Number"
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  _mobile = val;
                                });
                              },
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent, width: 2.0)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent, width: 2.0)),
                                  hintText: 'Phone',
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.black87)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      _email, _password);
                              Firestore.instance
                                  .collection("users")
                                  .document(result.uid)
                                  .setData({
                                "uid": result.uid,
                                "name": _name,
                                "email": _email,
                                "mobile": _mobile,
                                "profile_picture": "",
                                "emergency_contact1": "",
                                "emergency_contact2": "",
                                "emergency_contact3": "",
                              });
                              if (result == null) {
                                setState(() {
                                  error = "Enter a valid email";
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'SFUIDisplay',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          color: Colors.redAccent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Padding(
                        padding: EdgeInsets.fromLTRB(125, 0, 0, 0),
                        child: Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          onPressed: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(FontAwesomeIcons.google),
                              Text(
                                'Sign up with Google',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: 'SFUIDisplay'),
                              )
                            ],
                          ),
                          color: Colors.white,
                          elevation: 2,
                          textColor: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already have an account?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            RaisedButton(
                              padding: EdgeInsets.all(0),
                              elevation: 2,
                              color: Colors.white,
                              onPressed: () {
                                //widget.toggleView();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              ),
                            )
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}

import 'package:flutter/material.dart';
import 'package:calmity/screens/authenticate/register.dart';
import 'package:calmity/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calmity/shared/loading.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String _email = "";
  String _password = "";
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
                        "LOG IN",
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
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                                          color: Colors.red[600], width: 2.0)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red[600], width: 2.0)),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.black87)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(200, 0, 0, 0),
                          child: MaterialButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {},
                            child: Text(
                              "forgot your password?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .loginWithEmailAndPassword(_email, _password);
                              if (result == null) {
                                setState(() {
                                  error = "Invalid Credentials";
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Text(
                            'LOG IN',
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
                      SizedBox(height: 20.0),
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
                                'Sign in with Google',
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
                              "Don't have an account?",
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
                                      builder: (context) => Regis()),
                                );
                              },
                              child: Text(
                                "Register",
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

class Regis extends StatefulWidget {
  @override
  _RegisState createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  bool screen = false;

  @override
  Widget build(BuildContext context) {
    return Register();
  }
}

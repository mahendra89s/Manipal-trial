import 'package:flutter/material.dart';
import 'package:calmity/screens/authenticate/register.dart';
import 'package:calmity/screens/authenticate/sign_in.dart';
import 'package:calmity/screens/wrapper.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: <Widget>[
          SizedBox(height: 200.0),
          Center(
            child: Image(
              image: AssetImage('assets/logo.JPG'),
              height: 250.0,
              width: 250.0,
            ),
          ),
          SizedBox(height: 170.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  bool screen = true;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Wrapper(screen: screen)),
                  );
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                    side: BorderSide(color: Colors.redAccent, width: 2.0)),
                minWidth: 190.0,
                height: 45.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              MaterialButton(
                onPressed: () {
                  bool screen = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Wrapper(screen: screen)),
                  );
                },
                child: Text(
                  'REGISTER',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.redAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                    side: BorderSide(color: Colors.redAccent, width: 2.0)),
                minWidth: 190.0,
                height: 45.0,
              )
            ],
          )
        ],
      )),
    );
  }
}


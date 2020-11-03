import 'package:flutter/material.dart';
import 'package:calmity/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:calmity/screens/pages/chatroom.dart';

class Home extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(children: <Widget>[
          Text(
            "Home Page",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28.0),
          ),
          RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChannelPage()),
                );
              },
              child: Text('Chatroom')),
        ]),
      ),
    );
  }
}

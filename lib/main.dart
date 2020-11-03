import 'package:flutter/material.dart';
import 'package:calmity/models/user.dart';
import 'package:calmity/screens/index/index.dart';
import 'package:calmity/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:calmity/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Futura'),
        home: Index(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:calmity/bloc.navigation_bloc/navigation_bloc.dart';

class Home extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Text(
        "Home Page",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28.0),
      )),
    );
  }
}

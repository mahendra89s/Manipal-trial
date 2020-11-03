import 'package:flutter/material.dart';
import 'package:calmity/bloc.navigation_bloc/navigation_bloc.dart';

class Languages extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Languages",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}

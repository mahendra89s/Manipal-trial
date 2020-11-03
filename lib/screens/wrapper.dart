import 'package:flutter/material.dart';
import 'package:calmity/models/user.dart';
import 'package:calmity/screens/authenticate/authenicate.dart';
import 'package:calmity/screens/pages/home.dart';
import 'package:calmity/sidebar/sidebar.dart';
import 'package:calmity/sidebar/sidebar_layout.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final bool screen;
  Wrapper({this.screen});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate(page: screen);
    } else {
      return SideBarLayout();
    }
  }
}

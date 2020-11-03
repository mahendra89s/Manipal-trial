import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calmity/services/auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import '../sidebar/menu_item.dart';
import '../screens/pages/profile.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  final AuthService _auth = AuthService();

  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  final FirebaseAuth _auth1 = FirebaseAuth.instance;
  FirebaseUser user;
  String _userName = '';
  String _profile = '';
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
    initUser();
  }

  initUser() async {
    //user = await _auth1.currentUser();
    Firestore.instance
        .collection('users')
        .document((await _auth1.currentUser()).uid)
        .get()
        .then((value) {
      setState(() {
        _userName = value.data['name'].toString();
        _profile = value.data['profile_picture'].toString();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.redAccent,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      ListTile(
                        title: Text(
                          "$_userName",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w800),
                        ),
                        leading: ClipRRect(
                          //radius: 40,
                          borderRadius: BorderRadius.circular(100.0),
                          child:
                              //Icon(
                              //  Icons.perm_identity,
                              //  color: Colors.white,
                              //),
                              Image.network(
                            '$_profile',
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          //radius: 40,
                          //backgroundColor: Colors.red,
                        ),
                      ),
                      Divider(
                        height: 50,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        title: "Edit Profile",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.ProfileClickedEvent);
                        },
                      ),
                      MenuItem(
                        title: "Home",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.HomeClickedEvent);
                        },
                      ),
                      MenuItem(
                        title: "Donate",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.DonateClickedEvent);
                        },
                      ),
                      MenuItem(
                        title: "Language",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.LanguageClickedEvent);
                        },
                      ),
                      MenuItem(
                        title: "Emergency Services",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(
                              NavigationEvents.EmergencyServicesClickedEvent);
                        },
                      ),
                      MenuItem(
                        title: "Government Schemes",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(
                              NavigationEvents.EmergencyServicesClickedEvent);
                        },
                      ),
                      MenuItem(
                        title: "Instruction Manual",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(
                              NavigationEvents.InstructionManualClickedEvent);
                        },
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.settings,
                        title: "Settings",
                      ),
                      MenuItem(
                        icon: Icons.exit_to_app,
                        title: "Logout",
                        onTap: () async {
                          await _auth.SignOut();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Colors.redAccent,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.red[100],
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

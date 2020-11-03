import 'package:flutter/material.dart';
import 'package:calmity/bloc.navigation_bloc/navigation_bloc.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class Profile extends StatefulWidget with NavigationStates {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File _image;
  final FirebaseAuth _auth1 = FirebaseAuth.instance;
  FirebaseUser user;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController em1controller = TextEditingController();
  TextEditingController em2controller = TextEditingController();
  TextEditingController em3controller = TextEditingController();
  String _email = "";
  String _name = "";
  String _mobile = "";
  String _profile = "";
  String _uploadedFileURL = "";

  @override
  void initState() {
    super.initState();

    initUser();
  }

  initUser() async {
    user = await _auth1.currentUser();
    Firestore.instance
        .collection('users')
        .document((await _auth1.currentUser()).uid)
        .get()
        .then((value) {
      setState(() {
        namecontroller.text = value.data['name'].toString();
        mobilecontroller.text = value.data['mobile'].toString();
        emailcontroller.text = value.data['email'].toString();
        _uploadedFileURL = value.data['profile_picture'].toString();
        em1controller.text = value.data['emergency_contact1'].toString();
        em2controller.text = value.data['emergency_contact2'].toString();
        em3controller.text = value.data['emergency_contact3'].toString();
      });
    });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  //Upload Image
  uploadImage() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_images/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
    print('HEY');
  }

  updateProfile() async {
    uploadImage();

    Firestore.instance
        .collection('users')
        .document((await _auth1.currentUser()).uid)
        .updateData({
      "name": namecontroller.text,
      "email": emailcontroller.text,
      "mobile": mobilecontroller.text,
      "profile_picture": _uploadedFileURL,
      "emergency_contact1": em1controller.text,
      "emergency_contact2": em2controller.text,
      "emergency_contact3": em3controller.text,
    }).then((result) {
      print("new USer true");

      SnackBar snackbar = SnackBar(content: Text("Profile Updated"));
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }).catchError((onError) {
      print("onError");
      SnackBar snackbar = SnackBar(content: Text("Error"));
      _scaffoldKey.currentState.showSnackBar(snackbar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 100),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.red,
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              _image,
                              width: 200,
                              height: 200,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100)),
                            width: 190,
                            height: 190,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                '$_uploadedFileURL',
                                fit: BoxFit.fitHeight,
                                width: 200,
                                height: 200,
                              ),
                            ),

                            //Icon(
                            //  Icons.camera_alt,
                            //  color: Colors.grey[800],
                            //),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  prefixIcon: Icon(Icons.supervised_user_circle),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                controller: namecontroller,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                controller: emailcontroller,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                controller: mobilecontroller,
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                    //
                  ),
                ),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(children: <Widget>[
                  Text('Emergency Contacts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Emergency Contact 1',
                      prefixIcon: Icon(Icons.phone),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    controller: em1controller,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Emergency Contact 2',
                      prefixIcon: Icon(Icons.phone),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    controller: em2controller,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Emergency Contact 3',
                      prefixIcon: Icon(Icons.phone),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    controller: em3controller,
                  ),
                ]),
              ),
              SizedBox(height: 20),
              RaisedButton(
                padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                color: Colors.red,
                onPressed: updateProfile,
                child: Text(
                  'UPDATE',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'KumbhSans',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

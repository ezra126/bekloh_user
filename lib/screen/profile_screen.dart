import 'dart:io';
import 'package:bekloh_user/bloc/profile_update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  //ProfileScreen({Key key, this.title}) : super(key: key);

  //final String title;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File _pickedImage;
  final ImagePicker _picker = ImagePicker();
  String fileName;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return BlocProvider<ProfileUpdateBloc>(
      create: (BuildContext context) => ProfileUpdateBloc(),
      child: Builder(
        builder: (context){
          return BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>(
            builder: (BuildContext context, ProfileUpdateState state){
              return Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    actions: [
                      if (state is ProfileUpdatingNotInitializedState)  Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<ProfileUpdateBloc>(context).updateProfile();
                            },
                            child: Center(child: Text('Edit Profile')),
                          ))
                    ],
                  ),
                  key: _scaffoldKey,
                  body:   SingleChildScrollView(
                    child: Stack(
                      // overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                          color: Colors.blue[600],
                          height: MediaQuery.of(context).size.height * .4,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: _width * .1, top: _height * .05, right: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showPickOptionsDialog(context);
                                      },
                                      child: Container(
                                          child: CircleAvatar(
                                            radius: 40,
                                            child: _pickedImage == null
                                                ? Text('Picture')
                                                : null,
                                            backgroundImage: _pickedImage != null
                                                ? FileImage(_pickedImage)
                                                : null,
                                          ),
                                          height: _height * .13,
                                          width: _width * .28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          )),
                                    ),
                                    SizedBox(
                                      width: _width * .1 / 3,
                                    ),
                                    Text(
                                      'Israel Getahun',
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: _height * .05,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: _width * .09, right: _width * .09),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "10.2K",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Wallet",
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "10.2K",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Promo",
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "10.2K",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Rate",
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )

                                // SizedBox(width: 5 * SizeConfig.widthMultiplier,),
                              ],
                            ),
                          ),
                        ),
                        if (state is ProfileUpdatingNotInitializedState)
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.email),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('israelgetahun22@gmail.com')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('+251 929416014 ')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.language),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('speaks Amharic and Oromifa')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.home),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('lives in Addis Ababa , Ethiopia')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        if (state is ProfileOnUpdatingState)
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .4),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * .05,
                                  right: MediaQuery.of(context).size.width * .05),
                              child: Container(
                                padding: EdgeInsets.only(top: 40),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.person),
                                        labelText: 'Israel',
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.phone),
                                        labelText: '0929416014',
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.email),
                                        labelText: 'email',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    RaisedButton(
                                        onPressed: () {
                                          BlocProvider.of<ProfileUpdateBloc>(
                                              context)
                                              .submitEditingProfile();
                                        },
                                        child: Container(
                                          child: Text('Update User'),
                                          decoration: const BoxDecoration(),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          )

                        //    Container(color: Colors.lightBlue);
                      ],
                    ),
                  )


              );
            }

          );
        },

      ),
    );
  }

  void _loadPicker(ImageSource source) async {
    var picked = await _picker.getImage(source: source);
    if (picked != null) {
      _cropImage(picked);
    }
    Navigator.pop(context);
  }

  void showPickOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Pick from Gallery'),
              onTap: () {
                _loadPicker(ImageSource.gallery);
              },
            ),
            ListTile(
              title: Text('Take a picture'),
              onTap: () {
                _loadPicker(ImageSource.camera);
              },
            )
          ],
        ),
      ),
    );
  }

  void _cropImage(PickedFile picked) async {
    var cropped = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        statusBarColor: Colors.blue,
        toolbarColor: Colors.blue,
        toolbarTitle: 'Crop Image',
        toolbarWidgetColor: Colors.white,
      ),
      sourcePath: picked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
      ],
      maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        _pickedImage = cropped;
      });
      uploadPic();
    }
  }

  Future uploadPic() async {
    fileName = path.basename(_pickedImage.path);
    var firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    var uploadTask = firebaseStorageRef.putFile(_pickedImage);
    var taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print('Profile Picture uploaded');
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
  }
}

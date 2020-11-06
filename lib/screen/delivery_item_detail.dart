import 'dart:async';
import 'dart:io';

import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/screen/home_screen.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

enum LabourNeed { yes, no }
enum DeliverOrMoveTime { now, later }

class PackageDetailScreen extends StatefulWidget {
  @override
  _PackageDetailScreenState createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File _pickedImage;
  final ImagePicker _picker = ImagePicker();
  String fileName;
  List<File> images = [];
  LabourNeed labourNeed = LabourNeed.no;
  DeliverOrMoveTime deliverOrMoveTime;
  DateTime picked;
  DateTime selectedDate;
  TimeOfDay selectedTime;
  int numberOfLabour=0;
  DateTime scheduleTime;
  //final ValueChanged<TimeOfDay> selectTime;

  _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: "Select Booking Date",
      cancelText: 'Not now',
      confirmText: 'Book',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  bool checkScheduleTime(){
    bool isValid;
    int value=DateTime.now().difference(selectedDate).inMinutes;
    int pickedTime=(selectedTime.hour*60)+ selectedTime.minute;
    int curTime=(TimeOfDay.now().hour*60)+ TimeOfDay.now().minute;
    print(pickedTime-curTime);
    if(selectedDate.day==DateTime.now().day){
      if((pickedTime-curTime)>=29){
        isValid= true;
      }
      else isValid=false;
    }
    else{
      isValid=true;
    }
    return isValid;
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryBookingBloc, DeliveryBookingState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            BlocProvider.of<DeliveryBookingBloc>(context).add(BackPressedEvent());
            // Navigator.popUntil(context, ModalRoute.withName('/AddDestinationScreen'));
            Navigator.of(context).popUntil((route) => route.isFirst);
            //Navigator.pop(context);
            return false;
          },
          child: Scaffold(
              appBar: AppBar(
                title: Text('Service Detail'),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                color: Color(0xffe8edf1),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .23,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.white,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    'Take photo of your item(s)',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'This is extremly helpful for your delivery and move',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: images.length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: 50,
                                                        child: Image.file(
                                                          images[index],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Positioned(
                                                          right: -16,
                                                          top: -15,
                                                          child: IconButton(
                                                              icon: Icon(
                                                                Icons.cancel,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                                size: 18,
                                                              ),
                                                              onPressed: () =>
                                                                  setState(() {
                                                                    images.removeAt(
                                                                        index);
                                                                  })))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        images.length < 4
                                            ? GestureDetector(
                                                onTap: () {
                                                  showPickOptionsDialog(
                                                      context);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                    child:
                                                        Icon(Icons.camera_alt),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'what are the item(s) ?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .23,
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.white,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          )),
                      Text(
                        'do you want labour with transport ?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 10, left: 20, right: 20, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              child: ListTile(
                                  contentPadding: EdgeInsets.all(-5),
                                  title: Row(
                                    children: [
                                      Radio(
                                        value: LabourNeed.yes,
                                        groupValue: labourNeed,
                                        onChanged: (LabourNeed value) {
                                          setState(() {
                                            labourNeed = value;
                                          });
                                        },
                                      ),
                                      Text('Yes'),
                                    ],
                                  )),
                            ),
                            Container(
                              height: 50,
                              width: 120,
                              child: ListTile(
                                  title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Radio(
                                    value: LabourNeed.no,
                                    groupValue: labourNeed,
                                    onChanged: (LabourNeed value) {
                                      setState(() {
                                        labourNeed = value;
                                      });
                                    },
                                  ),
                                  Text('No'),
                                ],
                              )),
                            ),
                          ],
                        ),
                      ),
                      if (labourNeed == LabourNeed.yes)
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             Text('How many ?'),
                              SizedBox(width: 25,),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        if(numberOfLabour>1){
                                          numberOfLabour--;
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                  Text(numberOfLabour.toString()),
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        if(numberOfLabour<10){
                                          numberOfLabour++;
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.add),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      if (labourNeed == LabourNeed.yes)
                        Text(
                            '*note:  adding number of labour is going to charge you !!!'),

                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                        child: Container(
                          height: 40,
                          child: Row(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          deliverOrMoveTime = DeliverOrMoveTime.now;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text('DELIVER NOW'),
                                        ),
                                      ),
                                    ),
                                    if(deliverOrMoveTime==DeliverOrMoveTime.now)
                                    Positioned(
                                      top: 3,
                                      right: 4,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.done,
                                            size: 18,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          deliverOrMoveTime =
                                              DeliverOrMoveTime.later;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text('DELIVER LATER'),
                                        ),
                                      ),
                                    ),
                                    if(deliverOrMoveTime==DeliverOrMoveTime.later)
                                    Positioned(
                                      top: 3,
                                      right: 4,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.done,
                                            size: 18,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if(deliverOrMoveTime==DeliverOrMoveTime.later)
                        Padding(
                            padding:
                            EdgeInsets.only(left: 15, right: 15, top: 10,bottom: 15),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .23,
                              width: MediaQuery.of(context).size.width,
                              // color: Colors.white,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child:
                                        Text('Schedule your move/delivery'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.date_range),
                                              SizedBox(width: 10),
                                              Text(
                                                selectedDate==null ? 'Select Date':
                                                "${selectedDate.toLocal()}".split(' ')[0],
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black45),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                _selectDate(context);
                                              },
                                              child: Text(
                                                selectedDate==null ? 'Add':
                                                'Change',
                                                style:
                                                TextStyle(color: Colors.blue),
                                              ))
                                        ],
                                      ),
                                      SizedBox(height: 9,),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.access_time),
                                              SizedBox(width: 10),
                                              Text(
                                                selectedTime==null ? 'Select Time':
                                                "${selectedTime.format(context)}",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black45),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                _selectTime(context);
                                              },
                                              child: Text(
                                                selectedTime==null ? 'Add':
                                                'Change',
                                                style:
                                                TextStyle(color: Colors.blue),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      Container(
                        margin: EdgeInsets.only(bottom: 0),
                        child: GestureDetector(
                          onTap: () {
                            if(deliverOrMoveTime==DeliverOrMoveTime.now){
                              BlocProvider.of<DeliveryBookingBloc>(context).add(DetailsSubmittedEvent(scheduledTime: DateTime.now(),labour: numberOfLabour));
                              Navigator.pushNamed(context, chooseVechileAndPaymentRoute);
                            }
                            if(deliverOrMoveTime==DeliverOrMoveTime.later){
                              if(selectedTime!=null && selectedDate!=null){
                                setState(() {
                                  scheduleTime=new DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour,selectedTime.minute);
                                });
                               print('the set time');
                               print(scheduleTime.toString());
                               if(checkScheduleTime()){
                                 BlocProvider.of<DeliveryBookingBloc>(context).add(DetailsSubmittedEvent(scheduledTime: scheduleTime,labour: numberOfLabour));
                                 Navigator.pushNamed(context, chooseVechileAndPaymentRoute);
                               }
                                else{
                                 showAlertDialog(context, "Dear user, schedule time must be atleast 30 minute after now or select Deliver now option");
                               }
                              }
                              else{
                                if(selectedTime==null && selectedDate==null ){
                                  showAlertDialog(context, "please fill service time and date");
                                 }
                                else if(selectedTime==null && selectedDate!=null){
                                   showAlertDialog(context, "please fill service time");
                                 }
                                else if(selectedDate==null && selectedTime!=null){
                                   showAlertDialog(context, "please fill service Date");
                                 }
                              }
                            }

                           // BlocProvider.of<DeliveryBookingBloc>(context).add(DetailsSubmittedEvent());
                          //  Navigator.pushNamed(context, chooseVechileAndPaymentRoute);
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: MediaQuery.of(context).size.height * .1,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                color: Colors.blue,
                                child: Center(
                                  child: Text('Confirm'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }

  showAlertDialog(BuildContext context, String message) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(""),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
        setState(() {
          images.add(cropped);
        });
      });
      //uploadPic();
    }
  }
}

/*
*Stack(
            children: [
              if (state is DetailsNotFilledState)

                GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(state.booking.source.latitude, state.booking.source.longitude),
                      zoom: 6,
                    ),
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    compassEnabled: true,
                    rotateGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    onMapCreated: (GoogleMapController controller) async {
                      _Controller.complete(controller);
                      await location.getLocation().then((LocationData initialLoc) async {
                        print(initialLoc);
                        LatLng latLng = LatLng(initialLoc.latitude, initialLoc.longitude);
                        CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(latLng, 16);
                        final GoogleMapController controller=await  _Controller.future;
                        controller.moveCamera(cameraUpdate);
                      }
                      );

                    }),
            ],
          ),
          * */

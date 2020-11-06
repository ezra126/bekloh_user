import 'dart:typed_data';

import 'package:bekloh_user/model/delivery_booking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderViewScreen extends StatefulWidget {

  @override
  _OrderViewScreenState createState() => _OrderViewScreenState();
}

class _OrderViewScreenState extends State<OrderViewScreen> {
  Order order;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    order =ModalRoute.of(context).settings.arguments;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("ServiceID #00${order.id.toString()}"),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            color:  Color(0xffe8edf1),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*.75,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 10),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.blueGrey[50]),
                            height: 180,
                            width: MediaQuery.of(context).size.width,
                            child:  Image.memory(Uint8List.fromList(order.bookImage.codeUnits),fit: BoxFit.fill,),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Booking Date',style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(DateFormat.yMMMMd().format(DateTime.parse(order.bookingTime))),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Booking Time',style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(DateFormat('K:mm a').format(DateTime.parse(order.bookingTime))),
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pick Up Location',style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Text('megna arounf zemfmesh,addis ababa')
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('DrofOff Location',style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Text('megna arounf zemfmesh,addis ababa')
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Vechile Cost',style: TextStyle(fontWeight: FontWeight.bold),),
                                Text("23 birr"),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Labour Cost',style: TextStyle(fontWeight: FontWeight.bold),),
                                Text("23 birr"),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Estimate amount'),
                                Text("23 birr"),
                              ],
                            )),

                      ],
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}

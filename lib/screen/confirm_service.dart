import 'dart:typed_data';

import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/model/delivery_booking.dart';
import 'package:bekloh_user/services/OrderService/order_repository.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ConfirmServiceScreen extends StatefulWidget {
  @override
  _ConfirmServiceScreenState createState() => _ConfirmServiceScreenState();
}

class _ConfirmServiceScreenState extends State<ConfirmServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        BlocProvider.of<DeliveryBookingBloc>(context).add(BackPressedEvent());

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Confirm Booking'),
        ),
        body:BlocBuilder<DeliveryBookingBloc,DeliveryBookingState>(
          builder: (context,DeliveryBookingState state){
            if(state is DeliveryBookingNotConfirmedState){
              return Container(
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
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Booking Date',style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text(DateFormat.yMMMMd().format(state.booking.bookingTime)),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Booking Time',style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text(DateFormat('K:mm a').format(state.booking.bookingTime)),
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
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.blueGrey[50]),
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                child:  Image.memory(Uint8List.fromList(state.booking.bookImage.codeUnits),fit: BoxFit.fill,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        addOrder();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .1,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              color: Colors.blue,
                              child: Center(
                                child: Text('CONFIRM'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              );
            }
            return Container(
              child: Center(child: Text(BlocProvider.of<DeliveryBookingBloc>(context).state.toString()),),
            );
          },
        ),
      ),
    );
  }

  void addOrder(){
    var state = BlocProvider.of<DeliveryBookingBloc>(context).state;
    if(state  is DeliveryBookingNotConfirmedState){
      Order order=new Order();
      order.source=state.booking.source.toString();
      order.destination=state.booking.destination.toString();
      order.paymentType=state.booking.paymentType.toString().replaceFirst("PaymentType.", "");
      order.vechileType=state.booking.vechileType.toString().replaceFirst("VechileType.", "");
      order.bookingTime=DateFormat("yyyy-MM-dd HH:mm").format(state.booking.bookingTime);
      order.bookImage= state.booking.bookImage;
      order.deliveryServiceType=state.booking.deliveryServiceType.toString().toString().replaceFirst("DeliveryServiceType.", "");

     // context.repository<OrderRepository>().insert(order);
     // Navigator.of(context).popUntil((route) => route.isFirst);
   //  context.repository<OrderRepository>().deleteAllTrip();
       int pickedTime=(state.booking.bookingTime.hour*60)+ state.booking.bookingTime.minute;
       int curTime=(TimeOfDay.now().hour*60)+ TimeOfDay.now().minute;
       print((curTime-pickedTime).abs());
       int dif=((curTime-pickedTime).abs());
       print(dif);
       print(dif<28);

       if(dif<28){
         Navigator.pushNamed(context, searchDriverRoute);
       }
      else
        Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';

import 'dashed_line.dart';


//import 'package:taxi_app/widgets/dashed_line.dart';
//import 'package:taxi_app/widgets/taxi_booking_cancellation_dialog.dart';

class TaxiBookingStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryBookingBloc,DeliveryBookingState>(
      builder: (context, state) {
        int selectedTab = 1;
        DeliveryBookingState currentState = state;
        String title = "";

        switch (currentState.runtimeType) {
          case  DeliveryVechileAndPaymentTypeNotSelectedState:
            selectedTab = 1;
            title = "Choose Delivery Vechile";
            break;
          case  PaymentMethodNotSelectedState:
            selectedTab = 2;
            title = "Payment Method";
            break;

        }
        return Container(
          color: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                  ),

                  IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                      },
                      color: Colors.white),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),

            ],
          ),
        );
      },
    );
  }

  Widget buildTab(BuildContext context, String val, bool enabled) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
            color: enabled ? Colors.white : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.0)),
        child: Text(
          "$val",
          style: Theme.of(context).textTheme.headline.copyWith(
              color: enabled ? Colors.black : Colors.white, fontSize: 15),
        ));
  }
}